//
//  GamesList.swift
//  CasinoBrand
//
//  Created by Andrey Polyashev on 10/17/22.
//

// swiftlint:disable file_length

import Combine
import SwiftyJSON
import Foundation

private extension String {
    static let categoriesCachedKey: String = "categoriesCachedKey"
    static let producersCachedKey: String = "producersCachedKey"
}

public protocol IGamesService {
    func games(producerId: Int?) -> AnyPublisher<[MDGame], Error>
    func games(searchText: String?) -> AnyPublisher<[MDGame], Error>
    func games(categoryId: Int?, devId: String?) -> AnyPublisher<[MDGame], Error>
    func gameSession(gameIdentifier: String) -> AnyPublisher<GameSessionRequest.Model, Error>
    func producers() -> AnyPublisher<[Producer], Error>
    func cachedProducers() -> (isValid: Bool, [Producer])
    func categories() -> AnyPublisher<[CasinoCategory], Error>
    func cachedCategories() -> (isValid: Bool, [CasinoCategory])
    
    func favoriteGames() -> AnyPublisher<[MDGame], Error>
    func deleteFavoriteGame(gameId: Int) -> AnyPublisher<DeleteFavoriteGameResponse, Error>
    func addFavoriteGame(gameId: Int) -> AnyPublisher<AddFavoriteGameResponse, Error>
}

public final class GamesService: IGamesService {
    struct CategoryName: Codable {
        let id: Int
        let name: String
        let slug: String
        let dev_id: String
    }
    
    struct CategoriesWrapped: Codable {
        let categories: [CategoryName]
        let verison: Int
        var translated: Bool
    }
    
    private let requester: Requester
    private let storage: IStorage

    // MARK: - Inits

    public init(
        requester: Requester,
        storage: IStorage
    ) {
        self.requester = requester
        self.storage = storage
    }
        
    private func mainGames(
        producerId: Int? = nil,
        searchText: String? = nil,
        categoryId: Int? = nil,
        devId: String? = nil
    ) -> AnyPublisher<[MDGame], Error> {
        let request = GamesListRequest(query: .init(
            searchText: searchText,
            categoryId: categoryId,
            producerId: producerId,
            hasLive: false,
            devId: devId,
            page: 1,
            perPage: 500
        ))
        return requester.fetch(request: request)
            .map({ $0.items })
            .eraseToAnyPublisher()
    }
    
    public func games(categoryId: Int?, devId: String?) -> AnyPublisher<[MDGame], Error> {
        mainGames(categoryId: categoryId, devId: devId)
    }
    
    public func games(searchText: String?) -> AnyPublisher<[MDGame], Error> {
        mainGames(searchText: searchText)
    }

    public func games(producerId: Int?) -> AnyPublisher<[MDGame], Error> {
        mainGames(producerId: producerId)
    }
    
    public func producers() -> AnyPublisher<[Producer], Error> {
        let request = GameProducerRequest()
        return requester.fetchList(request: request)
            .handleEvents(receiveOutput: { [weak self] response in
                guard let data = JSONToDataConverter.convert(model: response) else {
                    return
                }
                let model = DataObject(identifier: .producersCachedKey, data: data)
                self?.storage.save(model: model)
            })
            .share()
            .eraseToAnyPublisher()
    }
    
    public func cachedProducers() -> (isValid: Bool, [Producer]) {
        guard let dataObject = storage.fetch(DataObject.self, identifier: .producersCachedKey),
              let cached: [Producer] = JSONToDataConverter.convert(data: dataObject.data) else {
            return (false, [])
        }
        
        let isValid = (Date().timeIntervalSince1970 - dataObject.timestamp) < .cacheLifetime1Day
        return (isValid, cached)
    }
    
    public func categories() -> AnyPublisher<[CasinoCategory], Error> {
        let request = CategoryRequest()
        return requester.fetchList(request: request)
            .handleEvents(receiveOutput: { [weak self] response in
                guard let data = JSONToDataConverter.convert(model: response) else {
                    return
                }
                let model = DataObject(identifier: .categoriesCachedKey, data: data)
                self?.storage.save(model: model)
            })
            .share()
            .eraseToAnyPublisher()
    }
    
    public func cachedCategories() -> (isValid: Bool, [CasinoCategory]) {
        guard let dataObject = storage.fetch(DataObject.self, identifier: .categoriesCachedKey),
              let cached: [CasinoCategory] = JSONToDataConverter.convert(data: dataObject.data) else {
            return (false, [])
        }
        
        let isValid = (Date().timeIntervalSince1970 - dataObject.timestamp) < .cacheLifetime1Day
        return (isValid, cached)
    }

    public func gameSession(gameIdentifier: String) -> AnyPublisher<GameSessionRequest.Model, Error> {
        let request = GameSessionRequest(gameIdentifier: gameIdentifier)
        return requester.fetch(request: request)
    }
    
    
    public func favoriteGames() -> AnyPublisher<[MDGame], Error> {
        let request = FavoriteGamesRequest()
        return requester.fetch(request: request)
            .map({ $0.items })
            .eraseToAnyPublisher()
    }
    
    public func deleteFavoriteGame(gameId: Int) -> AnyPublisher<DeleteFavoriteGameResponse, Error> {
        let request = DeleteFavoriteGameRequest(gameId: gameId)
        return requester.fetch(request: request)
    }
    
    public func addFavoriteGame(gameId: Int) -> AnyPublisher<AddFavoriteGameResponse, Error> {
        let request = AddFavoriteGameRequest(gameId: gameId)
        return requester.fetch(request: request)
    }
}

//extension GamesService {
//    static let availableGamesId: [String] = [
//        "vs50aladdin",
//        "vs25kingdomsnojp",
//        "vs243lions",
//        "vs1024lionsd",
//        "vs243lionsgold",
//        "vswayslions",
//        "vs7monkeys",
//        "vs7pigs",
//        "vs20eightdragons",
//        "vs1dragon8",
//        "vs20aladdinsorc",
//        "vs10egypt",
//        "vs10egyptcls",
//        "vs25asgard",
//        "vs25kfruit",
//        "vs7776aztec",
//        "vs5aztecgems",
//        "vs9aztecgemsdx",
//        "vs20farmfest",
//        "vs40beowulf",
//        "vs10bbbonanza",
//        "vswaysbbb",
//        "vs10bbkir",
//        "vs10txbigbass",
//        "vs40bigjuan",
//        "vs12bbb",
//        "vs20trswild2",
//        "vs25bomb",
//        "vs25bkofkngdm",
//        "vs10tut",
//        "vs10bookfallen",
//        "vswaysbook",
//        "vs10bookviking",
//        "vs25btygold",
//        "vs75bronco",
//        "vs4096bufking",
//        "vswaysbufking",
//        "vs243caishien",
//        "vs243fortune",
//        "vswaysstrwild",
//        "vswaysbankbonz",
//        "vs20terrorv",
//        "vs25copsrobbers",
//        "vs10chkchase",
//        "vs20chickdrop",
//        "vs25chilli",
//        "vswayschilheat",
//        "vs10bxmasbnza",
//        "vs20xmascarol",
//        "vs20cleocatra",
//        "vs20mustanggld2",
//        "vs20colcashzone",
//        "vs432congocash",
//        "vs40cosmiccash",
//        "vs10cowgold",
//        "vs10crownfire",
//        "vswayscryscav",
//        "vswayswerewolf",
//        "vs25davinci",
//        "vs243dancingpar",
//        "vs20daydead",
//        "vs15diamond",
//        "vs20underground",
//        "vs1600drago",
//        "vs5drhs",
//        "vs25dragonkingdom",
//        "vs5drmystery",
//        "vs20drtgold",
//        "vs25dwarves_new",
//        "vs20egypttrs",
//        "vswayselements",
//        "vs20eking",
//        "vs20ekingrr",
//        "vs20emptybank",
//        "vs10fruity2",
//        "vswaysxjuicy",
//        "vs40cleoeye",
//        "vs10eyestorm",
//        "vs15fairytale",
//        "vs7fire88",
//        "vs100firehot",
//        "vs20fh",
//        "vs40firehot",
//        "vs5firehot",
//        "vs10firestrike2",
//        "vswaysconcoll",
//        "vs10firestrike",
//        "vs10goldfish",
//        "vswaysfltdrg",
//        "vs10floatdrg",
//        "vs20amuleteg",
//        "vs20fruitparty",
//        "vs20fparty2",
//        "vs40frrainbow",
//        "vswaysfuryodin",
//        "vs20olympgate",
//        "vs10runes",
//        "vs20goldfever",
//        "vs20lcount",
//        "vs20gobnudge",
//        "vs25goldparty",
//        "vs25goldrush",
//        "vs3train",
//        "vs75empress",
//        "vs1024gmayhem",
//        "vs20rhino",
//        "vs20rhinoluxe",
//        "vswaysrhino",
//        "vs20wolfie",
//        "vs243fortseren",
//        "vs40mstrwild",
//        "vs25rio",
//        "vs50hercules",
//        "vs20hercpeg",
//        "vs20honey",
//        "vs9hotroll",
//        "vs25hotfiesta",
//        "vs25safari",
//        "vs5hotburn",
//        "vs40hotburnx",
//        "vs20hburnhs",
//        "vs1024butterfly",
//        "vs10mayangods",
//        "vs7776secrets",
//        "vs10bookoftut",
//        "vs20bermuda",
//        "vs25scarabqueen",
//        "vs25jokerking",
//        "vs5joker",
//        "vs25journey",
//        "vs50juicyfr",
//        "vs20gorilla",
//        "vs4096jurassic",
//        "vs20godiva",
//        "vs20leprexmas",
//        "vs20leprechaun",
//        "vs5littlegem",
//        "vs50chinesecharms",
//        "vs10luckcharm",
//        "vswayslight",
//        "vs25newyear",
//        "vs10madame",
//        "vswaysmadame",
//        "vs243crystalcave",
//        "vs8magicjourn",
//        "vs10mmm",
//        "vs4096magician",
//        "vs9chen",
//        "vs1masterjoker",
//        "vs50mightra",
//        "vs50kingkong",
//        "vs25mmouse",
//        "vs9madmonkey",
//        "vs243mwarrior",
//        "vs20muertos",
//        "vs25mustang",
//        "vs4096mystery",
//        "vs10wildtut",
//        "vswayswest",
//        "vs50northgard",
//        "vs20octobeer",
//        "vs25pandagold",
//        "vs25pandatemple",
//        "vs25pantherqueen",
//        "vs20pblinders",
//        "vs25peking",
//        "vs20phoenixf",
//        "vs9piggybank",
//        "vs40pirate",
//        "vs40pirgold",
//        "vs20mtreasure",
//        "vs50pixie",
//        "vswayshammthor",
//        "vs25pyramid",
//        "vs1024atlantis",
//        "vs10egrich",
//        "vs25queenofgold",
//        "vs243queenie",
//        "vs20rainbowg",
//        "vs20kraken",
//        "vs20kraken2",
//        "vs10returndead",
//        "vs10nudgeit",
//        "vs20rockvegas",
//        "vs50safariking",
//        "vs20santa",
//        "vs20porbs",
//        "vs20santawonder",
//        "vs20sparta",
//        "vs100sh",
//        "vs20sh",
//        "vs40sh",
//        "vs5sh",
//        "vs20smugcove",
//        "vs10snakeeyes",
//        "vs10snakeladd",
//        "vs40spartaking",
//        "vswaysfrywld",
//        "vs10spiritadv",
//        "vswayshive",
//        "vs10starpirate",
//        "vs20starlight",
//        "vs117649starz",
//        "vs40streetracer",
//        "vs5strh",
//        "vs20sugarrush",
//        "vs5super7",
//        "vs5spjoker",
//        "vs20superx",
//        "vs20fruitsw",
//        "vs20sbxmas",
//        "vs20swordofares",
//        "vs1024temuj",
//        "vs10amm",
//        "vs25champ",
//        "vs20doghouse",
//        "vswaysdogs",
//        "vs1024dtiger",
//        "vs20chicken",
//        "vs20stickysymbol",
//        "vs20midas",
//        "vs20magicpot",
//        "vs20ultim5",
//        "vs40madwheel",
//        "vs10threestar",
//        "vs10tictac",
//        "vs20theights",
//        "vs18mashang",
//        "vs20trsbox",
//        "vs1fortunetree",
//        "vs5trdragons",
//        "vs5trjokers",
//        "vs1tigers",
//        "vswaysjkrdrop",
//        "vs5ultrab",
//        "vs5ultra",
//        "vs10vampwolf",
//        "vs20vegasmagic",
//        "vs25vegas",
//        "vs40voodoo",
//        "vs20bchprty",
//        "vs20wildboost",
//        "vs40wanderw",
//        "vs25gladiator",
//        "vs20mparty",
//        "vs20wildpix",
//        "vs25wildspells",
//        "vs25walker",
//        "vs40wildwest",
//        "vswayswildwest",
//        "vs576treasures",
//        "vs25wolfgold",
//        "vswaysyumyum",
//        "vswayszombcarn",
//        "Baccarat3H",
//        "Blackjack",
//        "Blackjack3H",
//        "CaribbeanHoldem",
//        "CaribbeanStud",
//        "EURoulette",
//        "SG12Zodiacs",
//        "SG5LuckyLions",
//        "SG5Mariachis",
//        "SGAlienPlanet",
//        "SGAllForOne",
//        "SGArcaneElements",
//        "SGArcticWonders",
//        "SGAzlandsGold",
//        "SGBarnstormerBucks",
//        "SGBeforeTimeRunsOut",
//        "SGBikiniIsland",
//        "SGBirdOfThunder",
//        "SGBlackbeardsBounty",
//        "SGBombRunner",
//        "SGBombsAway",
//        "SGBuggyBonus",
//        "SGCakeValley",
//        "SGCalaverasExplosivas",
//        "SGCandyTower",
//        "SGCarnivalCash",
//        "SGCashReef",
//        "SGCashosaurus",
//        "SGChristmasGiftRush",
//        "SGColossalGems",
//        "SGCoyoteCrash",
//        "SGDiscoBeats",
//        "SGDiscoFunk",
//        "SGDoubleODollars",
//        "SGDrFeelGood",
//        "SGDragonTigerGate",
//        "SGDragonsRealm",
//        "SGDragonsThrone",
//        "SGEgyptianDreams",
//        "SGEgyptianDreamsDeluxe",
//        "SGFaCaiShen",
//        "SGFaCaiShenDeluxe",
//        "SGFenghuang",
//        "SGFireRooster",
//        "SGFly",
//        "SGFlyingHigh",
//        "SGFortuneDogs",
//        "SGFourDivineBeasts",
//        "SGFrontierFortunes",
//        "SGGalacticCash",
//        "SGGangsters",
//        "SGGlamRock",
//        "SGGoldRush",
//        "SGGoldenUnicorn",
//        "SGGoldenUnicornDeluxe",
//        "SGGrapeEscape",
//        "SGHappiestChristmasTree",
//        "SGHappyApe",
//        "SGHauntedHouse",
//        "SGHeySushi",
//        "SGHotHotFruit",
//        "SGHotHotHalloween",
//        "SGIndianCashCatcher",
//        "SGJellyfishFlow",
//        "SGJugglenaut",
//        "SGJump",
//        "SGJungleRumble",
//        "SGKanesInferno",
//        "SGKingTutsTomb",
//        "SGKnockoutFootball",
//        "SGKnockoutFootballRush",
//        "SGLanternLuck",
//        "SGLaughingBuddha",
//        "SGLittleGreenMoney",
//        "SGLondonHunter",
//        "SGLoonyBlox",
//        "SGLuckyDurian",
//        "SGLuckyFortuneCat",
//        "SGLuckyLucky",
//        "SGMagicOak",
//        "SGMarvelousFurlongs",
//        "SGMightyMedusa",
//        "SGMonsterMashCash",
//        "SGMountMazuma",
//        "SGMrBling",
//        "SGMummyMoney",
//        "SGMysticFortune",
//        "SGMysticFortuneDeluxe",
//        "SGNaughtySanta",
//        "SGNewYearsBash",
//        "SGNineTails",
//        "SGNuwa",
//        "SGOceansCall",
//        "SGOrbsOfAtlantis",
//        "SGPamperMe",
//        "SGPandaPanda",
//        "SGPiratesPlunder",
//        "SGPoolShark",
//        "SGPresto",
//        "SGProst",
//        "SGPuckerUpPrince",
//        "SGPumpkinPatch",
//        "SGQueenOfQueens1024",
//        "SGQueenOfQueens243",
//        "SGReturnToTheFeature",
//        "SGRideEmCowboy",
//        "SGRodeoDrive",
//        "SGRollingRoger",
//        "SGRomanEmpire",
//        "SGRuffledUp",
//        "SGSOS",
//        "SGSantasVillage",
//        "SGScopa",
//        "SGScruffyScallywags",
//        "SGShaolinFortunes100",
//        "SGShaolinFortunes243",
//        "SGShogunsLand",
//        "SGSirBlingalot",
//        "SGSkysTheLimit",
//        "SGSojuBomb",
//        "SGSpaceFortune",
//        "SGSpaceGoonz",
//        "SGSparta",
//        "SGSteamExpress",
//        "SGSuperStrike",
//        "SGSuperTwister",
//        "SGTabernaDeLosMuertos",
//        "SGTaikoBeats",
//        "SGTechnoTumble",
//        "SGTheBigDeal",
//        "SGTheDeadEscape",
//        "SGTheDragonCastle",
//        "SGTheKoiGate",
//        "SGTotemTowers",
//        "SGTowerOfPizza",
//        "SGTreasureDiver",
//        "SGTreasureTomb",
//        "SGTukTukThailand",
//        "SGVikingsPlunder",
//        "SGWaysOfFortune",
//        "SGWealthInn",
//        "SGWeirdScience",
//        "SGWickedWitch",
//        "SGWildTrucks",
//        "SGWizardsWantWar",
//        "SGZeus",
//        "SGZeus2",
//        "SicBo",
//        "TGDragonTiger",
//        "TGNiuNiuPoker",
//        "TGRaiseItUpPoker",
//        "TGThreeCardPoker",
//        "TGWar",
//        "VideoPokerMultiHand",
//        "714",
//        "649",
//        "737",
//        "671",
//        "696",
//        "674",
//        "595",
//        "713",
//        "726",
//        "648",
//        "675",
//        "727",
//        "807",
//        "405",
//        "531",
//        "617",
//        "418",
//        "708",
//        "349",
//        "443",
//        "579",
//        "374",
//        "342",
//        "52",
//        "386",
//        "446",
//        "664",
//        "310",
//        "646",
//        "590",
//        "585",
//        "686",
//        "587",
//        "460",
//        "419",
//        "588",
//        "309",
//        "600",
//        "389",
//        "591",
//        "452",
//        "787",
//        "359",
//        "194",
//        "685",
//        "810",
//        "567",
//        "407",
//        "612",
//        "476",
//        "535",
//        "653",
//        "427",
//        "417",
//        "259",
//        "262",
//        "638",
//        "614",
//        "473",
//        "307",
//        "466",
//        "622",
//        "609",
//        "589",
//        "540",
//        "596",
//        "618",
//        "468",
//        "286",
//        "642",
//        "549",
//        "574",
//        "693",
//        "344",
//        "447",
//        "436",
//        "285",
//        "341",
//        "424",
//        "469",
//        "808",
//        "464",
//        "375",
//        "568",
//        "666",
//        "454",
//        "581",
//        "633",
//        "641",
//        "366",
//        "689",
//        "306",
//        "242",
//        "639",
//        "553",
//        "278",
//        "470",
//        "416",
//        "339",
//        "755",
//        "660",
//        "656",
//        "608",
//        "456",
//        "610",
//        "735",
//        "298",
//        "320",
//        "625",
//        "620",
//        "603",
//        "334",
//        "712",
//        "644",
//        "645",
//        "283",
//        "245",
//        "754",
//        "629",
//        "690",
//        "241",
//        "373",
//        "371",
//        "684",
//        "291",
//        "640",
//        "345",
//        "328",
//        "619",
//        "613",
//        "607",
//        "361",
//        "333",
//        "429",
//        "384",
//        "411",
//        "451",
//        "367",
//        "584",
//        "377",
//        "670",
//        "352",
//        "586",
//        "624",
//        "378",
//        "632",
//        "422",
//        "530",
//        "606",
//        "321",
//        "662",
//        "413",
//        "709",
//        "340",
//        "351",
//        "295",
//        "710",
//        "336",
//        "570",
//        "444",
//        "471",
//        "583",
//        "472",
//        "376",
//        "474",
//        "365",
//        "287",
//        "396",
//        "254",
//        "450",
//        "659",
//        "319",
//        "563",
//        "661",
//        "647",
//        "398",
//        "294",
//        "616",
//        "426",
//        "541",
//        "387",
//        "397",
//        "901",
//        "453",
//        "399",
//        "40",
//        "315",
//        "408",
//        "672",
//        "853",
//        "729",
//        "680",
//        "816",
//        "643",
//        "681",
//        "700",
//        "421",
//        "350"
//    ]
//}
