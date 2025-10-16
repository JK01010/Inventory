import 'package:sqflite/sqflite.dart';

class VesselTable {
  static const tableName = 'Vessel';

  static const String siteID = "siteID";
  static const String siteCode = "siteCode";
  static const String siteTypeID = "siteTypeID";
  static const String id = "id";
  static const String imoNo = "imoNo";
  static const String vesselRegID = "vesselRegID";
  static const String vesselName = "vesselName";
  static const String code = "code";
  static const String maidenName = "maidenName";
  static const String vesselStatusID = "vesselStatusID";
  static const String ultimateOwnerID = "ultimateOwnerID";
  static const String isVesselFromNewOwner = "isVesselFromNewOwner";
  static const String registredOwnerID = "registredOwnerID";
  static const String managementTypeID = "managementTypeID";
  static const String isPartiallyCrewManaged = "isPartiallyCrewManaged";
  static const String primaryManagerID = "primaryManagerID";
  static const String subManagerID = "subManagerID";
  static const String fleetID = "fleetID";
  static const String vesselGroupID = "vesselGroupID";
  static const String vesselSubGroupID = "vesselSubGroupID";
  static const String vesselTypeID = "vesselTypeID";
  static const String vesselSubTypeID = "vesselSubTypeID";
  static const String vesselSizeID = "vesselSizeID";
  static const String classTypeID = "classTypeID";
  static const String classNo = "classNo";
  static const String classType2ID = "classType2ID";
  static const String classNo2 = "classNo2";
  static const String flagID = "flagID";
  static const String flagOfficialNo = "flagOfficialNo";
  static const String flagRegPortID = "flagRegPortID";
  static const String callSign = "callSign";
  static const String dwt = "dwt";
  static const String grt = "grt";
  static const String nrt = "nrt";
  static const String teu = "teu";
  static const String cbm = "cbm";
  static const String isRovingTeam = "isRovingTeam";
  static const String mainEngineMakeID = "mainEngineMakeID";
  static const String mainEnginModelID = "mainEnginModelID";
  static const String mainEngineOutput = "mainEngineOutput";
  static const String mainEngineBuilderID = "mainEngineBuilderID";
  static const String mainEngineNoOfUnits = "mainEngineNoOfUnits";
  static const String vesselSpeed = "vesselSpeed";
  static const String recordStatus = "recordStatus";
  static const String validFrom = "validFrom";
  static const String validTo = "validTo";
  static const String rejoinedVessel = "rejoinedVessel";
  static const String rejoinedON = "rejoinedON";
  static const String isSharedVessel = "isSharedVessel";
  static const String isDualClass = "isDualClass";
  static const String confirmedVesselID = "confirmedVesselID";
  static const String serviceCycleCounter = "serviceCycleCounter";
  static const String previousRecordID = "previousRecordID";
  static const String isHistoryExists = "isHistoryExists";
  static const String exVessel = "exVessel";
  static const String realVessel = "realVessel";
  static const String isAccountClosed = "isAccountClosed";
  static const String isActive = "isActive";
  static const String activeModifyByID = "activeModifyByID";
  static const String activeModifyOn = "activeModifyOn";
  static const String isDeleted = "isDeleted";
  static const String createdByID = "createdByID";
  static const String createdOn = "createdOn";
  static const String modifiedByID = "modifiedByID";
  static const String modifiedOn = "modifiedOn";
  static const String versionIdentifier = "versionIdentifier";
  static const String status = "status";
  static const String statusMessage = "statusMessage";
  static const String operationType = "operationType";

  static String createTableQuery = '''
  CREATE TABLE $tableName (
    $id INTEGER PRIMARY KEY,
    $siteID INTEGER,
    $siteCode TEXT,
    $siteTypeID INTEGER,
    $imoNo TEXT,
    $vesselRegID INTEGER,
    $vesselName TEXT,
    $code TEXT,
    $maidenName TEXT,
    $vesselStatusID INTEGER,
    $ultimateOwnerID INTEGER,
    $isVesselFromNewOwner INTEGER,
    $registredOwnerID INTEGER,
    $managementTypeID INTEGER,
    $isPartiallyCrewManaged INTEGER,
    $primaryManagerID INTEGER,
    $subManagerID INTEGER,
    $fleetID INTEGER,
    $vesselGroupID INTEGER,
    $vesselSubGroupID INTEGER,
    $vesselTypeID INTEGER,
    $vesselSubTypeID INTEGER,
    $vesselSizeID INTEGER,
    $classTypeID INTEGER,
    $classNo TEXT,
    $classType2ID INTEGER,
    $classNo2 TEXT,
    $flagID INTEGER,
    $flagOfficialNo TEXT,
    $flagRegPortID INTEGER,
    $callSign TEXT,
    $dwt INTEGER,
    $grt INTEGER,
    $nrt INTEGER,
    $teu INTEGER,
    $cbm INTEGER,
    $isRovingTeam INTEGER,
    $mainEngineMakeID INTEGER,
    $mainEnginModelID INTEGER,
    $mainEngineOutput INTEGER,
    $mainEngineBuilderID INTEGER,
    $mainEngineNoOfUnits INTEGER,
    $vesselSpeed TEXT,
    $recordStatus TEXT,
    $validFrom TEXT,
    $validTo TEXT,
    $rejoinedVessel INTEGER,
    $rejoinedON TEXT,
    $isSharedVessel INTEGER,
    $isDualClass INTEGER,
    $confirmedVesselID INTEGER,
    $serviceCycleCounter INTEGER,
    $previousRecordID INTEGER,
    $isHistoryExists INTEGER,
    $exVessel INTEGER,
    $realVessel INTEGER,
    $isAccountClosed INTEGER,
    $isActive INTEGER,
    $activeModifyByID INTEGER,
    $activeModifyOn TEXT,
    $isDeleted INTEGER,
    $createdByID INTEGER,
    $createdOn TEXT,
    $modifiedByID INTEGER,
    $modifiedOn TEXT,
    $versionIdentifier INTEGER,
    $status TEXT,
    $statusMessage TEXT,
    $operationType TEXT
  )
  ''';

  static Future<void> onUpgrade(
    Database db,
    int oldVersion,
    int newVersion,
  ) async {
    if (oldVersion < 2) {
      // example: add a new column
      await db.execute("ALTER TABLE $tableName ADD COLUMN newColumn TEXT");
    }
  }
}
