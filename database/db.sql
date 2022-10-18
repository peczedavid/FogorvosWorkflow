-- MySQL dump 10.13  Distrib 8.0.30, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: fogorvos_camunda
-- ------------------------------------------------------
-- Server version	8.0.30

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `act_ge_bytearray`
--

DROP TABLE IF EXISTS `act_ge_bytearray`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `act_ge_bytearray` (
  `ID_` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `REV_` int DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `DEPLOYMENT_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `BYTES_` longblob,
  `GENERATED_` tinyint DEFAULT NULL,
  `TENANT_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `TYPE_` int DEFAULT NULL,
  `CREATE_TIME_` datetime DEFAULT NULL,
  `ROOT_PROC_INST_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `REMOVAL_TIME_` datetime DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_FK_BYTEARR_DEPL` (`DEPLOYMENT_ID_`),
  KEY `ACT_IDX_BYTEARRAY_ROOT_PI` (`ROOT_PROC_INST_ID_`),
  KEY `ACT_IDX_BYTEARRAY_RM_TIME` (`REMOVAL_TIME_`),
  KEY `ACT_IDX_BYTEARRAY_NAME` (`NAME_`),
  CONSTRAINT `ACT_FK_BYTEARR_DEPL` FOREIGN KEY (`DEPLOYMENT_ID_`) REFERENCES `act_re_deployment` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_ge_bytearray`
--

LOCK TABLES `act_ge_bytearray` WRITE;
/*!40000 ALTER TABLE `act_ge_bytearray` DISABLE KEYS */;
INSERT INTO `act_ge_bytearray` VALUES ('66c5113b-4eed-11ed-8d77-ec2e98f6b919',1,'Process_Fogorvos.bpmn','66c5113a-4eed-11ed-8d77-ec2e98f6b919',_binary '<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<bpmn:definitions xmlns:bpmn=\"http://www.omg.org/spec/BPMN/20100524/MODEL\" xmlns:bpmndi=\"http://www.omg.org/spec/BPMN/20100524/DI\" xmlns:dc=\"http://www.omg.org/spec/DD/20100524/DC\" xmlns:camunda=\"http://camunda.org/schema/1.0/bpmn\" xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:di=\"http://www.omg.org/spec/DD/20100524/DI\" xmlns:modeler=\"http://camunda.org/schema/modeler/1.0\" id=\"Definitions_1bs2o47\" targetNamespace=\"http://bpmn.io/schema/bpmn\" exporter=\"Camunda Modeler\" exporterVersion=\"5.4.1\" modeler:executionPlatform=\"Camunda Platform\" modeler:executionPlatformVersion=\"7.18.0\">\n  <bpmn:process id=\"Process_Fogorvos\" name=\"Fogszabalyzo vizsgalat\" isExecutable=\"true\">\n    <bpmn:startEvent id=\"StartEvent_1\" name=\"Időpont lefoglalva\">\n      <bpmn:outgoing>Flow_0g21s5z</bpmn:outgoing>\n    </bpmn:startEvent>\n    <bpmn:userTask id=\"Activity_MegjelenesIdoponton\" name=\"Megjelenés az időponton\" camunda:assignee=\"${beteg}\">\n      <bpmn:incoming>Flow_0g21s5z</bpmn:incoming>\n      <bpmn:incoming>Flow_Kesik</bpmn:incoming>\n      <bpmn:outgoing>Flow_0vebpd8</bpmn:outgoing>\n    </bpmn:userTask>\n    <bpmn:sequenceFlow id=\"Flow_0g21s5z\" sourceRef=\"StartEvent_1\" targetRef=\"Activity_MegjelenesIdoponton\">\n      <bpmn:extensionElements />\n    </bpmn:sequenceFlow>\n    <bpmn:boundaryEvent id=\"Event_12fcodo\" attachedToRef=\"Activity_MegjelenesIdoponton\">\n      <bpmn:outgoing>Flow_1pldoo7</bpmn:outgoing>\n      <bpmn:timerEventDefinition id=\"TimerEventDefinition_01upsst\">\n        <bpmn:timeCycle xsi:type=\"bpmn:tFormalExpression\">R1/PT15S</bpmn:timeCycle>\n      </bpmn:timerEventDefinition>\n    </bpmn:boundaryEvent>\n    <bpmn:sequenceFlow id=\"Flow_1pldoo7\" name=\"Nem jelent meg időben\" sourceRef=\"Event_12fcodo\" targetRef=\"Activity_BetegErtesitese\" />\n    <bpmn:userTask id=\"Activity_BetegErtesitese\" name=\"Beteg értesítése\" camunda:assignee=\"${recepcios}\">\n      <bpmn:incoming>Flow_1pldoo7</bpmn:incoming>\n      <bpmn:outgoing>Flow_12v4apm</bpmn:outgoing>\n    </bpmn:userTask>\n    <bpmn:exclusiveGateway id=\"Gateway_11yug2o\">\n      <bpmn:incoming>Flow_12v4apm</bpmn:incoming>\n      <bpmn:outgoing>Flow_Kesik</bpmn:outgoing>\n      <bpmn:outgoing>Flow_Elmarad</bpmn:outgoing>\n    </bpmn:exclusiveGateway>\n    <bpmn:sequenceFlow id=\"Flow_12v4apm\" sourceRef=\"Activity_BetegErtesitese\" targetRef=\"Gateway_11yug2o\" />\n    <bpmn:sequenceFlow id=\"Flow_Kesik\" name=\"Késik\" sourceRef=\"Gateway_11yug2o\" targetRef=\"Activity_MegjelenesIdoponton\">\n      <bpmn:conditionExpression xsi:type=\"bpmn:tFormalExpression\">#{elmarad==false}</bpmn:conditionExpression>\n    </bpmn:sequenceFlow>\n    <bpmn:sequenceFlow id=\"Flow_Elmarad\" name=\"Elmarad\" sourceRef=\"Gateway_11yug2o\" targetRef=\"Activity_Szamlazas\">\n      <bpmn:conditionExpression xsi:type=\"bpmn:tFormalExpression\">#{elmarad==true}</bpmn:conditionExpression>\n    </bpmn:sequenceFlow>\n    <bpmn:userTask id=\"Activity_Vizsgalat\" name=\"Vizsgálat\" camunda:assignee=\"${orvos}\">\n      <bpmn:incoming>Flow_0vebpd8</bpmn:incoming>\n      <bpmn:outgoing>Flow_0399hr6</bpmn:outgoing>\n    </bpmn:userTask>\n    <bpmn:sequenceFlow id=\"Flow_0vebpd8\" sourceRef=\"Activity_MegjelenesIdoponton\" targetRef=\"Activity_Vizsgalat\" />\n    <bpmn:exclusiveGateway id=\"Gateway_080wnq4\">\n      <bpmn:incoming>Flow_0399hr6</bpmn:incoming>\n      <bpmn:outgoing>Flow_1hcm2qi</bpmn:outgoing>\n      <bpmn:outgoing>Flow_0w9vq7t</bpmn:outgoing>\n    </bpmn:exclusiveGateway>\n    <bpmn:sequenceFlow id=\"Flow_0399hr6\" sourceRef=\"Activity_Vizsgalat\" targetRef=\"Gateway_080wnq4\" />\n    <bpmn:sequenceFlow id=\"Flow_1hcm2qi\" name=\"Kell röntgen\" sourceRef=\"Gateway_080wnq4\" targetRef=\"Activity_Rontgen\">\n      <bpmn:conditionExpression xsi:type=\"bpmn:tFormalExpression\">#{rontgen==true}</bpmn:conditionExpression>\n    </bpmn:sequenceFlow>\n    <bpmn:userTask id=\"Activity_Rontgen\" name=\"Röntgen\" camunda:assignee=\"${rontgenes}\">\n      <bpmn:incoming>Flow_1hcm2qi</bpmn:incoming>\n      <bpmn:outgoing>Flow_1latask</bpmn:outgoing>\n    </bpmn:userTask>\n    <bpmn:sequenceFlow id=\"Flow_1latask\" sourceRef=\"Activity_Rontgen\" targetRef=\"Activity_0fx95tn\" />\n    <bpmn:userTask id=\"Activity_0fx95tn\" name=\"Felülvizsgálat\" camunda:assignee=\"${orvos}\">\n      <bpmn:incoming>Flow_1latask</bpmn:incoming>\n      <bpmn:outgoing>Flow_1y9czdy</bpmn:outgoing>\n    </bpmn:userTask>\n    <bpmn:exclusiveGateway id=\"Gateway_0z4tqtt\">\n      <bpmn:incoming>Flow_1y9czdy</bpmn:incoming>\n      <bpmn:outgoing>Flow_1gdxqwj</bpmn:outgoing>\n      <bpmn:outgoing>Flow_0zdca5p</bpmn:outgoing>\n    </bpmn:exclusiveGateway>\n    <bpmn:serviceTask id=\"Activity_Szamlazas\" name=\"Számlázás\" camunda:delegateExpression=\"${szamlazas}\">\n      <bpmn:incoming>Flow_Elmarad</bpmn:incoming>\n      <bpmn:incoming>Flow_1gdxqwj</bpmn:incoming>\n      <bpmn:incoming>Flow_11ycc2i</bpmn:incoming>\n      <bpmn:incoming>Flow_0kwbew9</bpmn:incoming>\n      <bpmn:incoming>Flow_0w9vq7t</bpmn:incoming>\n      <bpmn:outgoing>Flow_1a8v39i</bpmn:outgoing>\n    </bpmn:serviceTask>\n    <bpmn:sequenceFlow id=\"Flow_1y9czdy\" sourceRef=\"Activity_0fx95tn\" targetRef=\"Gateway_0z4tqtt\" />\n    <bpmn:sequenceFlow id=\"Flow_1gdxqwj\" name=\"Nem kell szakorvosi vizsgálat\" sourceRef=\"Gateway_0z4tqtt\" targetRef=\"Activity_Szamlazas\">\n      <bpmn:conditionExpression xsi:type=\"bpmn:tFormalExpression\">#{szakorvosiVizsgalat==false}</bpmn:conditionExpression>\n    </bpmn:sequenceFlow>\n    <bpmn:sequenceFlow id=\"Flow_0zdca5p\" name=\"Kell szakorvosi vizsgálat\" sourceRef=\"Gateway_0z4tqtt\" targetRef=\"Activity_0f6etab\">\n      <bpmn:conditionExpression xsi:type=\"bpmn:tFormalExpression\">#{szakorvosiVizsgalat==true}</bpmn:conditionExpression>\n    </bpmn:sequenceFlow>\n    <bpmn:exclusiveGateway id=\"Gateway_0ebpam6\">\n      <bpmn:incoming>Flow_1c567kq</bpmn:incoming>\n      <bpmn:outgoing>Flow_11ycc2i</bpmn:outgoing>\n      <bpmn:outgoing>Flow_0x6rr5j</bpmn:outgoing>\n    </bpmn:exclusiveGateway>\n    <bpmn:sequenceFlow id=\"Flow_1c567kq\" sourceRef=\"Activity_0f6etab\" targetRef=\"Gateway_0ebpam6\" />\n    <bpmn:sequenceFlow id=\"Flow_11ycc2i\" name=\"Nem kell fogszabályzó\" sourceRef=\"Gateway_0ebpam6\" targetRef=\"Activity_Szamlazas\">\n      <bpmn:conditionExpression xsi:type=\"bpmn:tFormalExpression\">#{fogszabalyzo==false}</bpmn:conditionExpression>\n    </bpmn:sequenceFlow>\n    <bpmn:parallelGateway id=\"Gateway_1ftbb45\">\n      <bpmn:incoming>Flow_0x6rr5j</bpmn:incoming>\n      <bpmn:outgoing>Flow_0ehb4wz</bpmn:outgoing>\n      <bpmn:outgoing>Flow_0kwbew9</bpmn:outgoing>\n    </bpmn:parallelGateway>\n    <bpmn:sequenceFlow id=\"Flow_0x6rr5j\" name=\"Kell fogszabályzó\" sourceRef=\"Gateway_0ebpam6\" targetRef=\"Gateway_1ftbb45\">\n      <bpmn:conditionExpression xsi:type=\"bpmn:tFormalExpression\">#{fogszabalyzo==true}</bpmn:conditionExpression>\n    </bpmn:sequenceFlow>\n    <bpmn:sequenceFlow id=\"Flow_0ehb4wz\" name=\"Fogszabályzó felrakása\" sourceRef=\"Gateway_1ftbb45\" targetRef=\"Activity_011nl0a\" />\n    <bpmn:sequenceFlow id=\"Flow_0kwbew9\" name=\"Számlázási folyamat\" sourceRef=\"Gateway_1ftbb45\" targetRef=\"Activity_Szamlazas\" />\n    <bpmn:endEvent id=\"EndEvent_1\" name=\"Fogorvosi folyamat vége\">\n      <bpmn:incoming>Flow_1a8v39i</bpmn:incoming>\n      <bpmn:incoming>Flow_0j5a4a5</bpmn:incoming>\n    </bpmn:endEvent>\n    <bpmn:sequenceFlow id=\"Flow_1a8v39i\" sourceRef=\"Activity_Szamlazas\" targetRef=\"EndEvent_1\" />\n    <bpmn:sequenceFlow id=\"Flow_0w9vq7t\" name=\"Nincs röntgen\" sourceRef=\"Gateway_080wnq4\" targetRef=\"Activity_Szamlazas\">\n      <bpmn:conditionExpression xsi:type=\"bpmn:tFormalExpression\">#{rontgen==false}</bpmn:conditionExpression>\n    </bpmn:sequenceFlow>\n    <bpmn:userTask id=\"Activity_0f6etab\" name=\"Szakorvosi vizsgálat\" camunda:assignee=\"${szakorvos}\">\n      <bpmn:incoming>Flow_0zdca5p</bpmn:incoming>\n      <bpmn:outgoing>Flow_1c567kq</bpmn:outgoing>\n    </bpmn:userTask>\n    <bpmn:userTask id=\"Activity_011nl0a\" name=\"Fogszabályzó felrakása\" camunda:assignee=\"${szakorvos}\">\n      <bpmn:incoming>Flow_0ehb4wz</bpmn:incoming>\n      <bpmn:outgoing>Flow_0j5a4a5</bpmn:outgoing>\n    </bpmn:userTask>\n    <bpmn:sequenceFlow id=\"Flow_0j5a4a5\" sourceRef=\"Activity_011nl0a\" targetRef=\"EndEvent_1\" />\n  </bpmn:process>\n  <bpmndi:BPMNDiagram id=\"BPMNDiagram_1\">\n    <bpmndi:BPMNPlane id=\"BPMNPlane_1\" bpmnElement=\"Process_Fogorvos\">\n      <bpmndi:BPMNShape id=\"_BPMNShape_StartEvent_2\" bpmnElement=\"StartEvent_1\">\n        <dc:Bounds x=\"142\" y=\"482\" width=\"36\" height=\"36\" />\n        <bpmndi:BPMNLabel>\n          <dc:Bounds x=\"119\" y=\"525\" width=\"87\" height=\"14\" />\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape id=\"Activity_0tsl2lg_di\" bpmnElement=\"Activity_MegjelenesIdoponton\">\n        <dc:Bounds x=\"290\" y=\"460\" width=\"100\" height=\"80\" />\n        <bpmndi:BPMNLabel />\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape id=\"Activity_1bzvgsw_di\" bpmnElement=\"Activity_BetegErtesitese\">\n        <dc:Bounds x=\"290\" y=\"290\" width=\"100\" height=\"80\" />\n        <bpmndi:BPMNLabel />\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape id=\"Gateway_11yug2o_di\" bpmnElement=\"Gateway_11yug2o\" isMarkerVisible=\"true\">\n        <dc:Bounds x=\"515\" y=\"305\" width=\"50\" height=\"50\" />\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape id=\"Activity_1uh2h37_di\" bpmnElement=\"Activity_Vizsgalat\">\n        <dc:Bounds x=\"290\" y=\"630\" width=\"100\" height=\"80\" />\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape id=\"Gateway_080wnq4_di\" bpmnElement=\"Gateway_080wnq4\" isMarkerVisible=\"true\">\n        <dc:Bounds x=\"475\" y=\"645\" width=\"50\" height=\"50\" />\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape id=\"Activity_1782shg_di\" bpmnElement=\"Activity_Rontgen\">\n        <dc:Bounds x=\"660\" y=\"630\" width=\"100\" height=\"80\" />\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape id=\"Activity_154nex5_di\" bpmnElement=\"Activity_0fx95tn\">\n        <dc:Bounds x=\"860\" y=\"630\" width=\"100\" height=\"80\" />\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape id=\"Gateway_0z4tqtt_di\" bpmnElement=\"Gateway_0z4tqtt\" isMarkerVisible=\"true\">\n        <dc:Bounds x=\"885\" y=\"465\" width=\"50\" height=\"50\" />\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape id=\"Activity_06d22y4_di\" bpmnElement=\"Activity_Szamlazas\">\n        <dc:Bounds x=\"660\" y=\"290\" width=\"100\" height=\"80\" />\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape id=\"Gateway_0ebpam6_di\" bpmnElement=\"Gateway_0ebpam6\" isMarkerVisible=\"true\">\n        <dc:Bounds x=\"1055\" y=\"305\" width=\"50\" height=\"50\" />\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape id=\"Gateway_14sezlx_di\" bpmnElement=\"Gateway_1ftbb45\">\n        <dc:Bounds x=\"1055\" y=\"195\" width=\"50\" height=\"50\" />\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape id=\"Event_0x16t54_di\" bpmnElement=\"EndEvent_1\">\n        <dc:Bounds x=\"662\" y=\"102\" width=\"36\" height=\"36\" />\n        <bpmndi:BPMNLabel>\n          <dc:Bounds x=\"646\" y=\"66\" width=\"68\" height=\"27\" />\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape id=\"Activity_095dhxd_di\" bpmnElement=\"Activity_0f6etab\">\n        <dc:Bounds x=\"1030\" y=\"450\" width=\"100\" height=\"80\" />\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape id=\"Activity_1djfazj_di\" bpmnElement=\"Activity_011nl0a\">\n        <dc:Bounds x=\"1030\" y=\"70\" width=\"100\" height=\"80\" />\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNShape id=\"Event_1o8ux07_di\" bpmnElement=\"Event_12fcodo\">\n        <dc:Bounds x=\"322\" y=\"442\" width=\"36\" height=\"36\" />\n      </bpmndi:BPMNShape>\n      <bpmndi:BPMNEdge id=\"Flow_0g21s5z_di\" bpmnElement=\"Flow_0g21s5z\">\n        <di:waypoint x=\"178\" y=\"500\" />\n        <di:waypoint x=\"290\" y=\"500\" />\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge id=\"Flow_1pldoo7_di\" bpmnElement=\"Flow_1pldoo7\">\n        <di:waypoint x=\"340\" y=\"442\" />\n        <di:waypoint x=\"340\" y=\"370\" />\n        <bpmndi:BPMNLabel>\n          <dc:Bounds x=\"251\" y=\"396\" width=\"78\" height=\"27\" />\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge id=\"Flow_12v4apm_di\" bpmnElement=\"Flow_12v4apm\">\n        <di:waypoint x=\"390\" y=\"330\" />\n        <di:waypoint x=\"515\" y=\"330\" />\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge id=\"Flow_1pyugwh_di\" bpmnElement=\"Flow_Kesik\">\n        <di:waypoint x=\"540\" y=\"355\" />\n        <di:waypoint x=\"540\" y=\"500\" />\n        <di:waypoint x=\"390\" y=\"500\" />\n        <bpmndi:BPMNLabel>\n          <dc:Bounds x=\"546\" y=\"423\" width=\"28\" height=\"14\" />\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge id=\"Flow_1yzwpjd_di\" bpmnElement=\"Flow_Elmarad\">\n        <di:waypoint x=\"565\" y=\"330\" />\n        <di:waypoint x=\"660\" y=\"330\" />\n        <bpmndi:BPMNLabel>\n          <dc:Bounds x=\"578\" y=\"312\" width=\"41\" height=\"14\" />\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge id=\"Flow_0vebpd8_di\" bpmnElement=\"Flow_0vebpd8\">\n        <di:waypoint x=\"340\" y=\"540\" />\n        <di:waypoint x=\"340\" y=\"630\" />\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge id=\"Flow_0399hr6_di\" bpmnElement=\"Flow_0399hr6\">\n        <di:waypoint x=\"390\" y=\"670\" />\n        <di:waypoint x=\"475\" y=\"670\" />\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge id=\"Flow_1hcm2qi_di\" bpmnElement=\"Flow_1hcm2qi\">\n        <di:waypoint x=\"525\" y=\"670\" />\n        <di:waypoint x=\"660\" y=\"670\" />\n        <bpmndi:BPMNLabel>\n          <dc:Bounds x=\"549\" y=\"652\" width=\"59\" height=\"14\" />\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge id=\"Flow_1latask_di\" bpmnElement=\"Flow_1latask\">\n        <di:waypoint x=\"760\" y=\"670\" />\n        <di:waypoint x=\"860\" y=\"670\" />\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge id=\"Flow_1y9czdy_di\" bpmnElement=\"Flow_1y9czdy\">\n        <di:waypoint x=\"910\" y=\"630\" />\n        <di:waypoint x=\"910\" y=\"515\" />\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge id=\"Flow_1gdxqwj_di\" bpmnElement=\"Flow_1gdxqwj\">\n        <di:waypoint x=\"910\" y=\"465\" />\n        <di:waypoint x=\"910\" y=\"330\" />\n        <di:waypoint x=\"760\" y=\"330\" />\n        <bpmndi:BPMNLabel>\n          <dc:Bounds x=\"854\" y=\"390\" width=\"52\" height=\"40\" />\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge id=\"Flow_0zdca5p_di\" bpmnElement=\"Flow_0zdca5p\">\n        <di:waypoint x=\"935\" y=\"490\" />\n        <di:waypoint x=\"1030\" y=\"490\" />\n        <bpmndi:BPMNLabel>\n          <dc:Bounds x=\"946\" y=\"496\" width=\"74\" height=\"27\" />\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge id=\"Flow_1c567kq_di\" bpmnElement=\"Flow_1c567kq\">\n        <di:waypoint x=\"1080\" y=\"450\" />\n        <di:waypoint x=\"1080\" y=\"355\" />\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge id=\"Flow_11ycc2i_di\" bpmnElement=\"Flow_11ycc2i\">\n        <di:waypoint x=\"1055\" y=\"330\" />\n        <di:waypoint x=\"760\" y=\"330\" />\n        <bpmndi:BPMNLabel>\n          <dc:Bounds x=\"968\" y=\"296\" width=\"64\" height=\"27\" />\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge id=\"Flow_0x6rr5j_di\" bpmnElement=\"Flow_0x6rr5j\">\n        <di:waypoint x=\"1080\" y=\"305\" />\n        <di:waypoint x=\"1080\" y=\"245\" />\n        <bpmndi:BPMNLabel>\n          <dc:Bounds x=\"1097\" y=\"272\" width=\"86\" height=\"14\" />\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge id=\"Flow_0ehb4wz_di\" bpmnElement=\"Flow_0ehb4wz\">\n        <di:waypoint x=\"1080\" y=\"195\" />\n        <di:waypoint x=\"1080\" y=\"150\" />\n        <bpmndi:BPMNLabel>\n          <dc:Bounds x=\"1086\" y=\"170\" width=\"68\" height=\"27\" />\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge id=\"Flow_0kwbew9_di\" bpmnElement=\"Flow_0kwbew9\">\n        <di:waypoint x=\"1055\" y=\"220\" />\n        <di:waypoint x=\"730\" y=\"220\" />\n        <di:waypoint x=\"730\" y=\"290\" />\n        <bpmndi:BPMNLabel>\n          <dc:Bounds x=\"941\" y=\"186\" width=\"57\" height=\"27\" />\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge id=\"Flow_1a8v39i_di\" bpmnElement=\"Flow_1a8v39i\">\n        <di:waypoint x=\"680\" y=\"290\" />\n        <di:waypoint x=\"680\" y=\"138\" />\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge id=\"Flow_0w9vq7t_di\" bpmnElement=\"Flow_0w9vq7t\">\n        <di:waypoint x=\"500\" y=\"645\" />\n        <di:waypoint x=\"500\" y=\"550\" />\n        <di:waypoint x=\"710\" y=\"550\" />\n        <di:waypoint x=\"710\" y=\"370\" />\n        <bpmndi:BPMNLabel>\n          <dc:Bounds x=\"506\" y=\"563\" width=\"68\" height=\"14\" />\n        </bpmndi:BPMNLabel>\n      </bpmndi:BPMNEdge>\n      <bpmndi:BPMNEdge id=\"Flow_0j5a4a5_di\" bpmnElement=\"Flow_0j5a4a5\">\n        <di:waypoint x=\"1030\" y=\"120\" />\n        <di:waypoint x=\"698\" y=\"120\" />\n      </bpmndi:BPMNEdge>\n    </bpmndi:BPMNPlane>\n  </bpmndi:BPMNDiagram>\n</bpmn:definitions>\n',0,NULL,1,'2022-10-18 16:01:46',NULL,NULL);
/*!40000 ALTER TABLE `act_ge_bytearray` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_ge_property`
--

DROP TABLE IF EXISTS `act_ge_property`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `act_ge_property` (
  `NAME_` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `VALUE_` varchar(300) COLLATE utf8mb3_bin DEFAULT NULL,
  `REV_` int DEFAULT NULL,
  PRIMARY KEY (`NAME_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_ge_property`
--

LOCK TABLES `act_ge_property` WRITE;
/*!40000 ALTER TABLE `act_ge_property` DISABLE KEYS */;
INSERT INTO `act_ge_property` VALUES ('camunda.installation.id','f29b0066-b8d7-4a2d-99f8-cf96cc6a5ab8',1),('camunda.telemetry.enabled','true',2),('deployment.lock','0',1),('history.cleanup.job.lock','0',1),('historyLevel','3',1),('installationId.lock','0',1),('next.dbid','1',1),('schema.history','create(fox)',1),('schema.version','fox',1),('startup.lock','0',1),('telemetry.lock','0',1);
/*!40000 ALTER TABLE `act_ge_property` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_ge_schema_log`
--

DROP TABLE IF EXISTS `act_ge_schema_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `act_ge_schema_log` (
  `ID_` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `TIMESTAMP_` datetime DEFAULT NULL,
  `VERSION_` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_ge_schema_log`
--

LOCK TABLES `act_ge_schema_log` WRITE;
/*!40000 ALTER TABLE `act_ge_schema_log` DISABLE KEYS */;
INSERT INTO `act_ge_schema_log` VALUES ('0','2022-10-18 15:47:24','7.18.0');
/*!40000 ALTER TABLE `act_ge_schema_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_hi_actinst`
--

DROP TABLE IF EXISTS `act_hi_actinst`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `act_hi_actinst` (
  `ID_` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `PARENT_ACT_INST_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `PROC_DEF_KEY_` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `ROOT_PROC_INST_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `ACT_ID_` varchar(255) COLLATE utf8mb3_bin NOT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `CALL_PROC_INST_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `CALL_CASE_INST_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `ACT_NAME_` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `ACT_TYPE_` varchar(255) COLLATE utf8mb3_bin NOT NULL,
  `ASSIGNEE_` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `START_TIME_` datetime NOT NULL,
  `END_TIME_` datetime DEFAULT NULL,
  `DURATION_` bigint DEFAULT NULL,
  `ACT_INST_STATE_` int DEFAULT NULL,
  `SEQUENCE_COUNTER_` bigint DEFAULT NULL,
  `TENANT_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `REMOVAL_TIME_` datetime DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_HI_ACTINST_ROOT_PI` (`ROOT_PROC_INST_ID_`),
  KEY `ACT_IDX_HI_ACT_INST_START_END` (`START_TIME_`,`END_TIME_`),
  KEY `ACT_IDX_HI_ACT_INST_END` (`END_TIME_`),
  KEY `ACT_IDX_HI_ACT_INST_PROCINST` (`PROC_INST_ID_`,`ACT_ID_`),
  KEY `ACT_IDX_HI_ACT_INST_COMP` (`EXECUTION_ID_`,`ACT_ID_`,`END_TIME_`,`ID_`),
  KEY `ACT_IDX_HI_ACT_INST_STATS` (`PROC_DEF_ID_`,`PROC_INST_ID_`,`ACT_ID_`,`END_TIME_`,`ACT_INST_STATE_`),
  KEY `ACT_IDX_HI_ACT_INST_TENANT_ID` (`TENANT_ID_`),
  KEY `ACT_IDX_HI_ACT_INST_PROC_DEF_KEY` (`PROC_DEF_KEY_`),
  KEY `ACT_IDX_HI_AI_PDEFID_END_TIME` (`PROC_DEF_ID_`,`END_TIME_`),
  KEY `ACT_IDX_HI_ACT_INST_RM_TIME` (`REMOVAL_TIME_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_hi_actinst`
--

LOCK TABLES `act_hi_actinst` WRITE;
/*!40000 ALTER TABLE `act_hi_actinst` DISABLE KEYS */;
INSERT INTO `act_hi_actinst` VALUES ('6f9848b3-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919','Process_Fogorvos','Process_Fogorvos:2:66d6283c-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919','6f9848b2-4eed-11ed-8d77-ec2e98f6b919','Activity_MegjelenesIdoponton','6f99cf56-4eed-11ed-8d77-ec2e98f6b919',NULL,NULL,'Megjelenés az időponton','userTask','fogorvosdemo','2022-10-18 16:02:00','2022-10-18 16:02:21',20900,2,3,NULL,NULL),('7f067ac3-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919','Process_Fogorvos','Process_Fogorvos:2:66d6283c-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919','7f0653b2-4eed-11ed-8d77-ec2e98f6b919','Activity_MegjelenesIdoponton','7f06a1d6-4eed-11ed-8d77-ec2e98f6b919',NULL,NULL,'Megjelenés az időponton','userTask','fogorvosdemo','2022-10-18 16:02:26','2022-10-18 16:02:52',25520,4,11,NULL,NULL),('93d53cf5-4eeb-11ed-a18b-ec2e98f6b919','93d38f30-4eeb-11ed-a18b-ec2e98f6b919','Process_Fogorvos','Process_Fogorvos:1:88fc727c-4eeb-11ed-a18b-ec2e98f6b919','93d38f30-4eeb-11ed-a18b-ec2e98f6b919','93d38f30-4eeb-11ed-a18b-ec2e98f6b919','93d53cf4-4eeb-11ed-a18b-ec2e98f6b919','Activity_MegjelenesIdoponton','93d62758-4eeb-11ed-a18b-ec2e98f6b919',NULL,NULL,'Megjelenés az időponton','userTask','fogorvosdemo','2022-10-18 15:48:42','2022-10-18 15:48:54',11524,4,3,NULL,NULL),('Activity_0f6etab:91196710-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919','Process_Fogorvos','Process_Fogorvos:2:66d6283c-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919','Activity_0f6etab','91196711-4eed-11ed-8d77-ec2e98f6b919',NULL,NULL,'Szakorvosi vizsgálat','userTask','fogorvosdemo','2022-10-18 16:02:57','2022-10-18 16:02:58',1024,4,23,NULL,NULL),('Activity_0fx95tn:9017ae79-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919','Process_Fogorvos','Process_Fogorvos:2:66d6283c-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919','Activity_0fx95tn','9017ae7a-4eed-11ed-8d77-ec2e98f6b919',NULL,NULL,'Felülvizsgálat','userTask','fogorvosdemo','2022-10-18 16:02:55','2022-10-18 16:02:57',1690,4,19,NULL,NULL),('Activity_BetegErtesitese:7bc5a79a-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919','Process_Fogorvos','Process_Fogorvos:2:66d6283c-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919','Activity_BetegErtesitese','7bc5a79b-4eed-11ed-8d77-ec2e98f6b919',NULL,NULL,'Beteg értesítése','userTask','fogorvosdemo','2022-10-18 16:02:21','2022-10-18 16:02:26',5366,4,7,NULL,NULL),('Activity_Rontgen:8f30f7f3-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919','Process_Fogorvos','Process_Fogorvos:2:66d6283c-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919','Activity_Rontgen','8f30f7f4-4eed-11ed-8d77-ec2e98f6b919',NULL,NULL,'Röntgen','userTask','fogorvosdemo','2022-10-18 16:02:53','2022-10-18 16:02:55',2003,4,17,NULL,NULL),('Activity_Szamlazas:50d67125-4eed-11ed-a18b-ec2e98f6b919','93d38f30-4eeb-11ed-a18b-ec2e98f6b919','Process_Fogorvos','Process_Fogorvos:1:88fc727c-4eeb-11ed-a18b-ec2e98f6b919','93d38f30-4eeb-11ed-a18b-ec2e98f6b919','93d38f30-4eeb-11ed-a18b-ec2e98f6b919','93d38f30-4eeb-11ed-a18b-ec2e98f6b919','Activity_Szamlazas',NULL,NULL,NULL,'Számlázás','serviceTask',NULL,'2022-10-18 16:01:09','2022-10-18 16:01:09',2,4,9,NULL,NULL),('Activity_Szamlazas:91e4f477-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919','Process_Fogorvos','Process_Fogorvos:2:66d6283c-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919','Activity_Szamlazas',NULL,NULL,NULL,'Számlázás','serviceTask',NULL,'2022-10-18 16:02:58','2022-10-18 16:02:58',1,4,27,NULL,NULL),('Activity_Vizsgalat:8e04acec-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919','Process_Fogorvos','Process_Fogorvos:2:66d6283c-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919','Activity_Vizsgalat','8e04aced-4eed-11ed-8d77-ec2e98f6b919',NULL,NULL,'Vizsgálat','userTask','fogorvosdemo','2022-10-18 16:02:52','2022-10-18 16:02:53',1489,4,13,NULL,NULL),('Activity_Vizsgalat:9a8916ce-4eeb-11ed-a18b-ec2e98f6b919','93d38f30-4eeb-11ed-a18b-ec2e98f6b919','Process_Fogorvos','Process_Fogorvos:1:88fc727c-4eeb-11ed-a18b-ec2e98f6b919','93d38f30-4eeb-11ed-a18b-ec2e98f6b919','93d38f30-4eeb-11ed-a18b-ec2e98f6b919','93d38f30-4eeb-11ed-a18b-ec2e98f6b919','Activity_Vizsgalat','9a8916cf-4eeb-11ed-a18b-ec2e98f6b919',NULL,NULL,'Vizsgálat','userTask','fogorvosdemo','2022-10-18 15:48:54','2022-10-18 16:01:09',734877,4,5,NULL,NULL),('EndEvent_1:50d6bf46-4eed-11ed-a18b-ec2e98f6b919','93d38f30-4eeb-11ed-a18b-ec2e98f6b919','Process_Fogorvos','Process_Fogorvos:1:88fc727c-4eeb-11ed-a18b-ec2e98f6b919','93d38f30-4eeb-11ed-a18b-ec2e98f6b919','93d38f30-4eeb-11ed-a18b-ec2e98f6b919','93d38f30-4eeb-11ed-a18b-ec2e98f6b919','EndEvent_1',NULL,NULL,NULL,'Fogorvosi folyamat vége','noneEndEvent',NULL,'2022-10-18 16:01:09','2022-10-18 16:01:09',0,1,11,NULL,NULL),('EndEvent_1:91e54298-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919','Process_Fogorvos','Process_Fogorvos:2:66d6283c-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919','EndEvent_1',NULL,NULL,NULL,'Fogorvosi folyamat vége','noneEndEvent',NULL,'2022-10-18 16:02:58','2022-10-18 16:02:58',0,1,29,NULL,NULL),('Event_12fcodo:7bc5a799-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919','Process_Fogorvos','Process_Fogorvos:2:66d6283c-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919','Event_12fcodo',NULL,NULL,NULL,NULL,'boundaryTimer',NULL,'2022-10-18 16:02:21','2022-10-18 16:02:21',0,4,5,NULL,NULL),('Gateway_080wnq4:50d5fbf4-4eed-11ed-a18b-ec2e98f6b919','93d38f30-4eeb-11ed-a18b-ec2e98f6b919','Process_Fogorvos','Process_Fogorvos:1:88fc727c-4eeb-11ed-a18b-ec2e98f6b919','93d38f30-4eeb-11ed-a18b-ec2e98f6b919','93d38f30-4eeb-11ed-a18b-ec2e98f6b919','93d38f30-4eeb-11ed-a18b-ec2e98f6b919','Gateway_080wnq4',NULL,NULL,NULL,NULL,'exclusiveGateway',NULL,'2022-10-18 16:01:09','2022-10-18 16:01:09',3,4,7,NULL,NULL),('Gateway_080wnq4:8f30a9d2-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919','Process_Fogorvos','Process_Fogorvos:2:66d6283c-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919','Gateway_080wnq4',NULL,NULL,NULL,NULL,'exclusiveGateway',NULL,'2022-10-18 16:02:53','2022-10-18 16:02:53',2,4,15,NULL,NULL),('Gateway_0ebpam6:91e4cd66-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919','Process_Fogorvos','Process_Fogorvos:2:66d6283c-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919','Gateway_0ebpam6',NULL,NULL,NULL,NULL,'exclusiveGateway',NULL,'2022-10-18 16:02:58','2022-10-18 16:02:58',1,4,25,NULL,NULL),('Gateway_0z4tqtt:911918ef-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919','Process_Fogorvos','Process_Fogorvos:2:66d6283c-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919','Gateway_0z4tqtt',NULL,NULL,NULL,NULL,'exclusiveGateway',NULL,'2022-10-18 16:02:57','2022-10-18 16:02:57',2,4,21,NULL,NULL),('Gateway_11yug2o:7f060591-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919','Process_Fogorvos','Process_Fogorvos:2:66d6283c-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919','Gateway_11yug2o',NULL,NULL,NULL,NULL,'exclusiveGateway',NULL,'2022-10-18 16:02:26','2022-10-18 16:02:26',2,4,9,NULL,NULL),('StartEvent_1:6f97d381-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919','Process_Fogorvos','Process_Fogorvos:2:66d6283c-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919','StartEvent_1',NULL,NULL,NULL,'Időpont lefoglalva','startEvent',NULL,'2022-10-18 16:02:00','2022-10-18 16:02:00',1,4,1,NULL,NULL),('StartEvent_1:93d4a0b3-4eeb-11ed-a18b-ec2e98f6b919','93d38f30-4eeb-11ed-a18b-ec2e98f6b919','Process_Fogorvos','Process_Fogorvos:1:88fc727c-4eeb-11ed-a18b-ec2e98f6b919','93d38f30-4eeb-11ed-a18b-ec2e98f6b919','93d38f30-4eeb-11ed-a18b-ec2e98f6b919','93d38f30-4eeb-11ed-a18b-ec2e98f6b919','StartEvent_1',NULL,NULL,NULL,'Időpont lefoglalva','startEvent',NULL,'2022-10-18 15:48:42','2022-10-18 15:48:42',3,4,1,NULL,NULL);
/*!40000 ALTER TABLE `act_hi_actinst` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_hi_attachment`
--

DROP TABLE IF EXISTS `act_hi_attachment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `act_hi_attachment` (
  `ID_` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `REV_` int DEFAULT NULL,
  `USER_ID_` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `DESCRIPTION_` varchar(4000) COLLATE utf8mb3_bin DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `ROOT_PROC_INST_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `URL_` varchar(4000) COLLATE utf8mb3_bin DEFAULT NULL,
  `CONTENT_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `TENANT_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `CREATE_TIME_` datetime DEFAULT NULL,
  `REMOVAL_TIME_` datetime DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_HI_ATTACHMENT_CONTENT` (`CONTENT_ID_`),
  KEY `ACT_IDX_HI_ATTACHMENT_ROOT_PI` (`ROOT_PROC_INST_ID_`),
  KEY `ACT_IDX_HI_ATTACHMENT_PROCINST` (`PROC_INST_ID_`),
  KEY `ACT_IDX_HI_ATTACHMENT_TASK` (`TASK_ID_`),
  KEY `ACT_IDX_HI_ATTACHMENT_RM_TIME` (`REMOVAL_TIME_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_hi_attachment`
--

LOCK TABLES `act_hi_attachment` WRITE;
/*!40000 ALTER TABLE `act_hi_attachment` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_hi_attachment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_hi_batch`
--

DROP TABLE IF EXISTS `act_hi_batch`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `act_hi_batch` (
  `ID_` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `TYPE_` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `TOTAL_JOBS_` int DEFAULT NULL,
  `JOBS_PER_SEED_` int DEFAULT NULL,
  `INVOCATIONS_PER_JOB_` int DEFAULT NULL,
  `SEED_JOB_DEF_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `MONITOR_JOB_DEF_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `BATCH_JOB_DEF_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `TENANT_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `CREATE_USER_ID_` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `START_TIME_` datetime NOT NULL,
  `END_TIME_` datetime DEFAULT NULL,
  `REMOVAL_TIME_` datetime DEFAULT NULL,
  `EXEC_START_TIME_` datetime DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_HI_BAT_RM_TIME` (`REMOVAL_TIME_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_hi_batch`
--

LOCK TABLES `act_hi_batch` WRITE;
/*!40000 ALTER TABLE `act_hi_batch` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_hi_batch` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_hi_caseactinst`
--

DROP TABLE IF EXISTS `act_hi_caseactinst`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `act_hi_caseactinst` (
  `ID_` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `PARENT_ACT_INST_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `CASE_DEF_ID_` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `CASE_INST_ID_` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `CASE_ACT_ID_` varchar(255) COLLATE utf8mb3_bin NOT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `CALL_PROC_INST_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `CALL_CASE_INST_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `CASE_ACT_NAME_` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `CASE_ACT_TYPE_` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `CREATE_TIME_` datetime NOT NULL,
  `END_TIME_` datetime DEFAULT NULL,
  `DURATION_` bigint DEFAULT NULL,
  `STATE_` int DEFAULT NULL,
  `REQUIRED_` tinyint(1) DEFAULT NULL,
  `TENANT_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_HI_CAS_A_I_CREATE` (`CREATE_TIME_`),
  KEY `ACT_IDX_HI_CAS_A_I_END` (`END_TIME_`),
  KEY `ACT_IDX_HI_CAS_A_I_COMP` (`CASE_ACT_ID_`,`END_TIME_`,`ID_`),
  KEY `ACT_IDX_HI_CAS_A_I_CASEINST` (`CASE_INST_ID_`,`CASE_ACT_ID_`),
  KEY `ACT_IDX_HI_CAS_A_I_TENANT_ID` (`TENANT_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_hi_caseactinst`
--

LOCK TABLES `act_hi_caseactinst` WRITE;
/*!40000 ALTER TABLE `act_hi_caseactinst` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_hi_caseactinst` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_hi_caseinst`
--

DROP TABLE IF EXISTS `act_hi_caseinst`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `act_hi_caseinst` (
  `ID_` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `CASE_INST_ID_` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `BUSINESS_KEY_` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `CASE_DEF_ID_` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `CREATE_TIME_` datetime NOT NULL,
  `CLOSE_TIME_` datetime DEFAULT NULL,
  `DURATION_` bigint DEFAULT NULL,
  `STATE_` int DEFAULT NULL,
  `CREATE_USER_ID_` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `SUPER_CASE_INSTANCE_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `SUPER_PROCESS_INSTANCE_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `TENANT_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  UNIQUE KEY `CASE_INST_ID_` (`CASE_INST_ID_`),
  KEY `ACT_IDX_HI_CAS_I_CLOSE` (`CLOSE_TIME_`),
  KEY `ACT_IDX_HI_CAS_I_BUSKEY` (`BUSINESS_KEY_`),
  KEY `ACT_IDX_HI_CAS_I_TENANT_ID` (`TENANT_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_hi_caseinst`
--

LOCK TABLES `act_hi_caseinst` WRITE;
/*!40000 ALTER TABLE `act_hi_caseinst` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_hi_caseinst` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_hi_comment`
--

DROP TABLE IF EXISTS `act_hi_comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `act_hi_comment` (
  `ID_` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `TYPE_` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `TIME_` datetime NOT NULL,
  `USER_ID_` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `ROOT_PROC_INST_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `ACTION_` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `MESSAGE_` varchar(4000) COLLATE utf8mb3_bin DEFAULT NULL,
  `FULL_MSG_` longblob,
  `TENANT_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `REMOVAL_TIME_` datetime DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_HI_COMMENT_TASK` (`TASK_ID_`),
  KEY `ACT_IDX_HI_COMMENT_ROOT_PI` (`ROOT_PROC_INST_ID_`),
  KEY `ACT_IDX_HI_COMMENT_PROCINST` (`PROC_INST_ID_`),
  KEY `ACT_IDX_HI_COMMENT_RM_TIME` (`REMOVAL_TIME_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_hi_comment`
--

LOCK TABLES `act_hi_comment` WRITE;
/*!40000 ALTER TABLE `act_hi_comment` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_hi_comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_hi_dec_in`
--

DROP TABLE IF EXISTS `act_hi_dec_in`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `act_hi_dec_in` (
  `ID_` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `DEC_INST_ID_` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `CLAUSE_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `CLAUSE_NAME_` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `VAR_TYPE_` varchar(100) COLLATE utf8mb3_bin DEFAULT NULL,
  `BYTEARRAY_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `DOUBLE_` double DEFAULT NULL,
  `LONG_` bigint DEFAULT NULL,
  `TEXT_` varchar(4000) COLLATE utf8mb3_bin DEFAULT NULL,
  `TEXT2_` varchar(4000) COLLATE utf8mb3_bin DEFAULT NULL,
  `TENANT_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `CREATE_TIME_` datetime DEFAULT NULL,
  `ROOT_PROC_INST_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `REMOVAL_TIME_` datetime DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_HI_DEC_IN_INST` (`DEC_INST_ID_`),
  KEY `ACT_IDX_HI_DEC_IN_CLAUSE` (`DEC_INST_ID_`,`CLAUSE_ID_`),
  KEY `ACT_IDX_HI_DEC_IN_ROOT_PI` (`ROOT_PROC_INST_ID_`),
  KEY `ACT_IDX_HI_DEC_IN_RM_TIME` (`REMOVAL_TIME_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_hi_dec_in`
--

LOCK TABLES `act_hi_dec_in` WRITE;
/*!40000 ALTER TABLE `act_hi_dec_in` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_hi_dec_in` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_hi_dec_out`
--

DROP TABLE IF EXISTS `act_hi_dec_out`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `act_hi_dec_out` (
  `ID_` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `DEC_INST_ID_` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `CLAUSE_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `CLAUSE_NAME_` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `RULE_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `RULE_ORDER_` int DEFAULT NULL,
  `VAR_NAME_` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `VAR_TYPE_` varchar(100) COLLATE utf8mb3_bin DEFAULT NULL,
  `BYTEARRAY_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `DOUBLE_` double DEFAULT NULL,
  `LONG_` bigint DEFAULT NULL,
  `TEXT_` varchar(4000) COLLATE utf8mb3_bin DEFAULT NULL,
  `TEXT2_` varchar(4000) COLLATE utf8mb3_bin DEFAULT NULL,
  `TENANT_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `CREATE_TIME_` datetime DEFAULT NULL,
  `ROOT_PROC_INST_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `REMOVAL_TIME_` datetime DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_HI_DEC_OUT_INST` (`DEC_INST_ID_`),
  KEY `ACT_IDX_HI_DEC_OUT_RULE` (`RULE_ORDER_`,`CLAUSE_ID_`),
  KEY `ACT_IDX_HI_DEC_OUT_ROOT_PI` (`ROOT_PROC_INST_ID_`),
  KEY `ACT_IDX_HI_DEC_OUT_RM_TIME` (`REMOVAL_TIME_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_hi_dec_out`
--

LOCK TABLES `act_hi_dec_out` WRITE;
/*!40000 ALTER TABLE `act_hi_dec_out` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_hi_dec_out` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_hi_decinst`
--

DROP TABLE IF EXISTS `act_hi_decinst`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `act_hi_decinst` (
  `ID_` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `DEC_DEF_ID_` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `DEC_DEF_KEY_` varchar(255) COLLATE utf8mb3_bin NOT NULL,
  `DEC_DEF_NAME_` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `PROC_DEF_KEY_` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `CASE_DEF_KEY_` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `CASE_DEF_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `CASE_INST_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `ACT_INST_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `ACT_ID_` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `EVAL_TIME_` datetime NOT NULL,
  `REMOVAL_TIME_` datetime DEFAULT NULL,
  `COLLECT_VALUE_` double DEFAULT NULL,
  `USER_ID_` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `ROOT_DEC_INST_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `ROOT_PROC_INST_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `DEC_REQ_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `DEC_REQ_KEY_` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `TENANT_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_HI_DEC_INST_ID` (`DEC_DEF_ID_`),
  KEY `ACT_IDX_HI_DEC_INST_KEY` (`DEC_DEF_KEY_`),
  KEY `ACT_IDX_HI_DEC_INST_PI` (`PROC_INST_ID_`),
  KEY `ACT_IDX_HI_DEC_INST_CI` (`CASE_INST_ID_`),
  KEY `ACT_IDX_HI_DEC_INST_ACT` (`ACT_ID_`),
  KEY `ACT_IDX_HI_DEC_INST_ACT_INST` (`ACT_INST_ID_`),
  KEY `ACT_IDX_HI_DEC_INST_TIME` (`EVAL_TIME_`),
  KEY `ACT_IDX_HI_DEC_INST_TENANT_ID` (`TENANT_ID_`),
  KEY `ACT_IDX_HI_DEC_INST_ROOT_ID` (`ROOT_DEC_INST_ID_`),
  KEY `ACT_IDX_HI_DEC_INST_REQ_ID` (`DEC_REQ_ID_`),
  KEY `ACT_IDX_HI_DEC_INST_REQ_KEY` (`DEC_REQ_KEY_`),
  KEY `ACT_IDX_HI_DEC_INST_ROOT_PI` (`ROOT_PROC_INST_ID_`),
  KEY `ACT_IDX_HI_DEC_INST_RM_TIME` (`REMOVAL_TIME_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_hi_decinst`
--

LOCK TABLES `act_hi_decinst` WRITE;
/*!40000 ALTER TABLE `act_hi_decinst` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_hi_decinst` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_hi_detail`
--

DROP TABLE IF EXISTS `act_hi_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `act_hi_detail` (
  `ID_` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `TYPE_` varchar(255) COLLATE utf8mb3_bin NOT NULL,
  `PROC_DEF_KEY_` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `ROOT_PROC_INST_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `CASE_DEF_KEY_` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `CASE_DEF_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `CASE_INST_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `CASE_EXECUTION_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `ACT_INST_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `VAR_INST_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8mb3_bin NOT NULL,
  `VAR_TYPE_` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `REV_` int DEFAULT NULL,
  `TIME_` datetime NOT NULL,
  `BYTEARRAY_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `DOUBLE_` double DEFAULT NULL,
  `LONG_` bigint DEFAULT NULL,
  `TEXT_` varchar(4000) COLLATE utf8mb3_bin DEFAULT NULL,
  `TEXT2_` varchar(4000) COLLATE utf8mb3_bin DEFAULT NULL,
  `SEQUENCE_COUNTER_` bigint DEFAULT NULL,
  `TENANT_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `OPERATION_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `REMOVAL_TIME_` datetime DEFAULT NULL,
  `INITIAL_` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_HI_DETAIL_ROOT_PI` (`ROOT_PROC_INST_ID_`),
  KEY `ACT_IDX_HI_DETAIL_PROC_INST` (`PROC_INST_ID_`),
  KEY `ACT_IDX_HI_DETAIL_ACT_INST` (`ACT_INST_ID_`),
  KEY `ACT_IDX_HI_DETAIL_CASE_INST` (`CASE_INST_ID_`),
  KEY `ACT_IDX_HI_DETAIL_CASE_EXEC` (`CASE_EXECUTION_ID_`),
  KEY `ACT_IDX_HI_DETAIL_TIME` (`TIME_`),
  KEY `ACT_IDX_HI_DETAIL_NAME` (`NAME_`),
  KEY `ACT_IDX_HI_DETAIL_TASK_ID` (`TASK_ID_`),
  KEY `ACT_IDX_HI_DETAIL_TENANT_ID` (`TENANT_ID_`),
  KEY `ACT_IDX_HI_DETAIL_PROC_DEF_KEY` (`PROC_DEF_KEY_`),
  KEY `ACT_IDX_HI_DETAIL_BYTEAR` (`BYTEARRAY_ID_`),
  KEY `ACT_IDX_HI_DETAIL_RM_TIME` (`REMOVAL_TIME_`),
  KEY `ACT_IDX_HI_DETAIL_TASK_BYTEAR` (`BYTEARRAY_ID_`,`TASK_ID_`),
  KEY `ACT_IDX_HI_DETAIL_VAR_INST_ID` (`VAR_INST_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_hi_detail`
--

LOCK TABLES `act_hi_detail` WRITE;
/*!40000 ALTER TABLE `act_hi_detail` DISABLE KEYS */;
INSERT INTO `act_hi_detail` VALUES ('6f973730-4eed-11ed-8d77-ec2e98f6b919','VariableUpdate','Process_Fogorvos','Process_Fogorvos:2:66d6283c-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919',NULL,NULL,NULL,NULL,NULL,'6f964cce-4eed-11ed-8d77-ec2e98f6b919','6f97101f-4eed-11ed-8d77-ec2e98f6b919','fogszabalyzo','boolean',0,'2022-10-18 16:02:00',NULL,NULL,0,NULL,NULL,1,NULL,NULL,NULL,1),('6f973732-4eed-11ed-8d77-ec2e98f6b919','VariableUpdate','Process_Fogorvos','Process_Fogorvos:2:66d6283c-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919',NULL,NULL,NULL,NULL,NULL,'6f964cce-4eed-11ed-8d77-ec2e98f6b919','6f973731-4eed-11ed-8d77-ec2e98f6b919','szakorvos','string',0,'2022-10-18 16:02:00',NULL,NULL,NULL,'fogorvosdemo',NULL,1,NULL,NULL,NULL,1),('6f973734-4eed-11ed-8d77-ec2e98f6b919','VariableUpdate','Process_Fogorvos','Process_Fogorvos:2:66d6283c-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919',NULL,NULL,NULL,NULL,NULL,'6f964cce-4eed-11ed-8d77-ec2e98f6b919','6f973733-4eed-11ed-8d77-ec2e98f6b919','elmarad','boolean',0,'2022-10-18 16:02:00',NULL,NULL,0,NULL,NULL,1,NULL,NULL,NULL,1),('6f973736-4eed-11ed-8d77-ec2e98f6b919','VariableUpdate','Process_Fogorvos','Process_Fogorvos:2:66d6283c-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919',NULL,NULL,NULL,NULL,NULL,'6f964cce-4eed-11ed-8d77-ec2e98f6b919','6f973735-4eed-11ed-8d77-ec2e98f6b919','orvos','string',0,'2022-10-18 16:02:00',NULL,NULL,NULL,'fogorvosdemo',NULL,1,NULL,NULL,NULL,1),('6f975e48-4eed-11ed-8d77-ec2e98f6b919','VariableUpdate','Process_Fogorvos','Process_Fogorvos:2:66d6283c-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919',NULL,NULL,NULL,NULL,NULL,'6f964cce-4eed-11ed-8d77-ec2e98f6b919','6f973737-4eed-11ed-8d77-ec2e98f6b919','beteg','string',0,'2022-10-18 16:02:00',NULL,NULL,NULL,'fogorvosdemo',NULL,1,NULL,NULL,NULL,1),('6f975e4a-4eed-11ed-8d77-ec2e98f6b919','VariableUpdate','Process_Fogorvos','Process_Fogorvos:2:66d6283c-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919',NULL,NULL,NULL,NULL,NULL,'6f964cce-4eed-11ed-8d77-ec2e98f6b919','6f975e49-4eed-11ed-8d77-ec2e98f6b919','rontgen','boolean',0,'2022-10-18 16:02:00',NULL,NULL,1,NULL,NULL,1,NULL,NULL,NULL,1),('6f975e4c-4eed-11ed-8d77-ec2e98f6b919','VariableUpdate','Process_Fogorvos','Process_Fogorvos:2:66d6283c-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919',NULL,NULL,NULL,NULL,NULL,'6f964cce-4eed-11ed-8d77-ec2e98f6b919','6f975e4b-4eed-11ed-8d77-ec2e98f6b919','szakorvosiVizsgalat','boolean',0,'2022-10-18 16:02:00',NULL,NULL,1,NULL,NULL,1,NULL,NULL,NULL,1),('6f975e4e-4eed-11ed-8d77-ec2e98f6b919','VariableUpdate','Process_Fogorvos','Process_Fogorvos:2:66d6283c-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919',NULL,NULL,NULL,NULL,NULL,'6f964cce-4eed-11ed-8d77-ec2e98f6b919','6f975e4d-4eed-11ed-8d77-ec2e98f6b919','rontgenes','string',0,'2022-10-18 16:02:00',NULL,NULL,NULL,'fogorvosdemo',NULL,1,NULL,NULL,NULL,1),('6f975e50-4eed-11ed-8d77-ec2e98f6b919','VariableUpdate','Process_Fogorvos','Process_Fogorvos:2:66d6283c-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919',NULL,NULL,NULL,NULL,NULL,'6f964cce-4eed-11ed-8d77-ec2e98f6b919','6f975e4f-4eed-11ed-8d77-ec2e98f6b919','recepcios','string',0,'2022-10-18 16:02:00',NULL,NULL,NULL,'fogorvosdemo',NULL,1,NULL,NULL,NULL,1),('93d40462-4eeb-11ed-a18b-ec2e98f6b919','VariableUpdate','Process_Fogorvos','Process_Fogorvos:1:88fc727c-4eeb-11ed-a18b-ec2e98f6b919','93d38f30-4eeb-11ed-a18b-ec2e98f6b919','93d38f30-4eeb-11ed-a18b-ec2e98f6b919','93d38f30-4eeb-11ed-a18b-ec2e98f6b919',NULL,NULL,NULL,NULL,NULL,'93d38f30-4eeb-11ed-a18b-ec2e98f6b919','93d40461-4eeb-11ed-a18b-ec2e98f6b919','fogszabalyzo','boolean',0,'2022-10-18 15:48:42',NULL,NULL,0,NULL,NULL,1,NULL,NULL,NULL,1),('93d40464-4eeb-11ed-a18b-ec2e98f6b919','VariableUpdate','Process_Fogorvos','Process_Fogorvos:1:88fc727c-4eeb-11ed-a18b-ec2e98f6b919','93d38f30-4eeb-11ed-a18b-ec2e98f6b919','93d38f30-4eeb-11ed-a18b-ec2e98f6b919','93d38f30-4eeb-11ed-a18b-ec2e98f6b919',NULL,NULL,NULL,NULL,NULL,'93d38f30-4eeb-11ed-a18b-ec2e98f6b919','93d40463-4eeb-11ed-a18b-ec2e98f6b919','szakorvos','string',0,'2022-10-18 15:48:42',NULL,NULL,NULL,'fogorvosdemo',NULL,1,NULL,NULL,NULL,1),('93d42b76-4eeb-11ed-a18b-ec2e98f6b919','VariableUpdate','Process_Fogorvos','Process_Fogorvos:1:88fc727c-4eeb-11ed-a18b-ec2e98f6b919','93d38f30-4eeb-11ed-a18b-ec2e98f6b919','93d38f30-4eeb-11ed-a18b-ec2e98f6b919','93d38f30-4eeb-11ed-a18b-ec2e98f6b919',NULL,NULL,NULL,NULL,NULL,'93d38f30-4eeb-11ed-a18b-ec2e98f6b919','93d42b75-4eeb-11ed-a18b-ec2e98f6b919','elmarad','boolean',0,'2022-10-18 15:48:42',NULL,NULL,0,NULL,NULL,1,NULL,NULL,NULL,1),('93d42b78-4eeb-11ed-a18b-ec2e98f6b919','VariableUpdate','Process_Fogorvos','Process_Fogorvos:1:88fc727c-4eeb-11ed-a18b-ec2e98f6b919','93d38f30-4eeb-11ed-a18b-ec2e98f6b919','93d38f30-4eeb-11ed-a18b-ec2e98f6b919','93d38f30-4eeb-11ed-a18b-ec2e98f6b919',NULL,NULL,NULL,NULL,NULL,'93d38f30-4eeb-11ed-a18b-ec2e98f6b919','93d42b77-4eeb-11ed-a18b-ec2e98f6b919','orvos','string',0,'2022-10-18 15:48:42',NULL,NULL,NULL,'fogorvosdemo',NULL,1,NULL,NULL,NULL,1),('93d42b7a-4eeb-11ed-a18b-ec2e98f6b919','VariableUpdate','Process_Fogorvos','Process_Fogorvos:1:88fc727c-4eeb-11ed-a18b-ec2e98f6b919','93d38f30-4eeb-11ed-a18b-ec2e98f6b919','93d38f30-4eeb-11ed-a18b-ec2e98f6b919','93d38f30-4eeb-11ed-a18b-ec2e98f6b919',NULL,NULL,NULL,NULL,NULL,'93d38f30-4eeb-11ed-a18b-ec2e98f6b919','93d42b79-4eeb-11ed-a18b-ec2e98f6b919','beteg','string',0,'2022-10-18 15:48:42',NULL,NULL,NULL,'fogorvosdemo',NULL,1,NULL,NULL,NULL,1),('93d42b7c-4eeb-11ed-a18b-ec2e98f6b919','VariableUpdate','Process_Fogorvos','Process_Fogorvos:1:88fc727c-4eeb-11ed-a18b-ec2e98f6b919','93d38f30-4eeb-11ed-a18b-ec2e98f6b919','93d38f30-4eeb-11ed-a18b-ec2e98f6b919','93d38f30-4eeb-11ed-a18b-ec2e98f6b919',NULL,NULL,NULL,NULL,NULL,'93d38f30-4eeb-11ed-a18b-ec2e98f6b919','93d42b7b-4eeb-11ed-a18b-ec2e98f6b919','rontgen','boolean',0,'2022-10-18 15:48:42',NULL,NULL,0,NULL,NULL,1,NULL,NULL,NULL,1),('93d42b7e-4eeb-11ed-a18b-ec2e98f6b919','VariableUpdate','Process_Fogorvos','Process_Fogorvos:1:88fc727c-4eeb-11ed-a18b-ec2e98f6b919','93d38f30-4eeb-11ed-a18b-ec2e98f6b919','93d38f30-4eeb-11ed-a18b-ec2e98f6b919','93d38f30-4eeb-11ed-a18b-ec2e98f6b919',NULL,NULL,NULL,NULL,NULL,'93d38f30-4eeb-11ed-a18b-ec2e98f6b919','93d42b7d-4eeb-11ed-a18b-ec2e98f6b919','szakorvosiVizsgalat','boolean',0,'2022-10-18 15:48:42',NULL,NULL,0,NULL,NULL,1,NULL,NULL,NULL,1),('93d42b80-4eeb-11ed-a18b-ec2e98f6b919','VariableUpdate','Process_Fogorvos','Process_Fogorvos:1:88fc727c-4eeb-11ed-a18b-ec2e98f6b919','93d38f30-4eeb-11ed-a18b-ec2e98f6b919','93d38f30-4eeb-11ed-a18b-ec2e98f6b919','93d38f30-4eeb-11ed-a18b-ec2e98f6b919',NULL,NULL,NULL,NULL,NULL,'93d38f30-4eeb-11ed-a18b-ec2e98f6b919','93d42b7f-4eeb-11ed-a18b-ec2e98f6b919','rontgenes','string',0,'2022-10-18 15:48:42',NULL,NULL,NULL,'fogorvosdemo',NULL,1,NULL,NULL,NULL,1),('93d42b82-4eeb-11ed-a18b-ec2e98f6b919','VariableUpdate','Process_Fogorvos','Process_Fogorvos:1:88fc727c-4eeb-11ed-a18b-ec2e98f6b919','93d38f30-4eeb-11ed-a18b-ec2e98f6b919','93d38f30-4eeb-11ed-a18b-ec2e98f6b919','93d38f30-4eeb-11ed-a18b-ec2e98f6b919',NULL,NULL,NULL,NULL,NULL,'93d38f30-4eeb-11ed-a18b-ec2e98f6b919','93d42b81-4eeb-11ed-a18b-ec2e98f6b919','recepcios','string',0,'2022-10-18 15:48:42',NULL,NULL,NULL,'fogorvosdemo',NULL,1,NULL,NULL,NULL,1);
/*!40000 ALTER TABLE `act_hi_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_hi_ext_task_log`
--

DROP TABLE IF EXISTS `act_hi_ext_task_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `act_hi_ext_task_log` (
  `ID_` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `TIMESTAMP_` timestamp NOT NULL,
  `EXT_TASK_ID_` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `RETRIES_` int DEFAULT NULL,
  `TOPIC_NAME_` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `WORKER_ID_` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `PRIORITY_` bigint NOT NULL DEFAULT '0',
  `ERROR_MSG_` varchar(4000) COLLATE utf8mb3_bin DEFAULT NULL,
  `ERROR_DETAILS_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `ACT_ID_` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `ACT_INST_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `ROOT_PROC_INST_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `PROC_DEF_KEY_` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `TENANT_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `STATE_` int DEFAULT NULL,
  `REV_` int DEFAULT NULL,
  `REMOVAL_TIME_` datetime DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_HI_EXT_TASK_LOG_ROOT_PI` (`ROOT_PROC_INST_ID_`),
  KEY `ACT_HI_EXT_TASK_LOG_PROCINST` (`PROC_INST_ID_`),
  KEY `ACT_HI_EXT_TASK_LOG_PROCDEF` (`PROC_DEF_ID_`),
  KEY `ACT_HI_EXT_TASK_LOG_PROC_DEF_KEY` (`PROC_DEF_KEY_`),
  KEY `ACT_HI_EXT_TASK_LOG_TENANT_ID` (`TENANT_ID_`),
  KEY `ACT_IDX_HI_EXTTASKLOG_ERRORDET` (`ERROR_DETAILS_ID_`),
  KEY `ACT_HI_EXT_TASK_LOG_RM_TIME` (`REMOVAL_TIME_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_hi_ext_task_log`
--

LOCK TABLES `act_hi_ext_task_log` WRITE;
/*!40000 ALTER TABLE `act_hi_ext_task_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_hi_ext_task_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_hi_identitylink`
--

DROP TABLE IF EXISTS `act_hi_identitylink`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `act_hi_identitylink` (
  `ID_` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `TIMESTAMP_` timestamp NOT NULL,
  `TYPE_` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `USER_ID_` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `GROUP_ID_` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `ROOT_PROC_INST_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `OPERATION_TYPE_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `ASSIGNER_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `PROC_DEF_KEY_` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `TENANT_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `REMOVAL_TIME_` datetime DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_HI_IDENT_LNK_ROOT_PI` (`ROOT_PROC_INST_ID_`),
  KEY `ACT_IDX_HI_IDENT_LNK_USER` (`USER_ID_`),
  KEY `ACT_IDX_HI_IDENT_LNK_GROUP` (`GROUP_ID_`),
  KEY `ACT_IDX_HI_IDENT_LNK_TENANT_ID` (`TENANT_ID_`),
  KEY `ACT_IDX_HI_IDENT_LNK_PROC_DEF_KEY` (`PROC_DEF_KEY_`),
  KEY `ACT_IDX_HI_IDENT_LINK_TASK` (`TASK_ID_`),
  KEY `ACT_IDX_HI_IDENT_LINK_RM_TIME` (`REMOVAL_TIME_`),
  KEY `ACT_IDX_HI_IDENT_LNK_TIMESTAMP` (`TIMESTAMP_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_hi_identitylink`
--

LOCK TABLES `act_hi_identitylink` WRITE;
/*!40000 ALTER TABLE `act_hi_identitylink` DISABLE KEYS */;
INSERT INTO `act_hi_identitylink` VALUES ('6f99cf57-4eed-11ed-8d77-ec2e98f6b919','2022-10-18 14:02:00','assignee','fogorvosdemo',NULL,'6f99cf56-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919','Process_Fogorvos:2:66d6283c-4eed-11ed-8d77-ec2e98f6b919','add',NULL,'Process_Fogorvos',NULL,NULL),('7bc61ccc-4eed-11ed-8d77-ec2e98f6b919','2022-10-18 14:02:21','assignee','fogorvosdemo',NULL,'7bc5a79b-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919','Process_Fogorvos:2:66d6283c-4eed-11ed-8d77-ec2e98f6b919','add',NULL,'Process_Fogorvos',NULL,NULL),('7f06a1d7-4eed-11ed-8d77-ec2e98f6b919','2022-10-18 14:02:26','assignee','fogorvosdemo',NULL,'7f06a1d6-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919','Process_Fogorvos:2:66d6283c-4eed-11ed-8d77-ec2e98f6b919','add','fogorvosdemo','Process_Fogorvos',NULL,NULL),('8e04d3fe-4eed-11ed-8d77-ec2e98f6b919','2022-10-18 14:02:52','assignee','fogorvosdemo',NULL,'8e04aced-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919','Process_Fogorvos:2:66d6283c-4eed-11ed-8d77-ec2e98f6b919','add','fogorvosdemo','Process_Fogorvos',NULL,NULL),('8f30f7f5-4eed-11ed-8d77-ec2e98f6b919','2022-10-18 14:02:53','assignee','fogorvosdemo',NULL,'8f30f7f4-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919','Process_Fogorvos:2:66d6283c-4eed-11ed-8d77-ec2e98f6b919','add','fogorvosdemo','Process_Fogorvos',NULL,NULL),('9017d58b-4eed-11ed-8d77-ec2e98f6b919','2022-10-18 14:02:55','assignee','fogorvosdemo',NULL,'9017ae7a-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919','Process_Fogorvos:2:66d6283c-4eed-11ed-8d77-ec2e98f6b919','add','fogorvosdemo','Process_Fogorvos',NULL,NULL),('91196712-4eed-11ed-8d77-ec2e98f6b919','2022-10-18 14:02:57','assignee','fogorvosdemo',NULL,'91196711-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919','Process_Fogorvos:2:66d6283c-4eed-11ed-8d77-ec2e98f6b919','add','fogorvosdemo','Process_Fogorvos',NULL,NULL),('93d62759-4eeb-11ed-a18b-ec2e98f6b919','2022-10-18 13:48:42','assignee','fogorvosdemo',NULL,'93d62758-4eeb-11ed-a18b-ec2e98f6b919','93d38f30-4eeb-11ed-a18b-ec2e98f6b919','Process_Fogorvos:1:88fc727c-4eeb-11ed-a18b-ec2e98f6b919','add',NULL,'Process_Fogorvos',NULL,NULL),('9a898c00-4eeb-11ed-a18b-ec2e98f6b919','2022-10-18 13:48:54','assignee','fogorvosdemo',NULL,'9a8916cf-4eeb-11ed-a18b-ec2e98f6b919','93d38f30-4eeb-11ed-a18b-ec2e98f6b919','Process_Fogorvos:1:88fc727c-4eeb-11ed-a18b-ec2e98f6b919','add','fogorvosdemo','Process_Fogorvos',NULL,NULL);
/*!40000 ALTER TABLE `act_hi_identitylink` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_hi_incident`
--

DROP TABLE IF EXISTS `act_hi_incident`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `act_hi_incident` (
  `ID_` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `PROC_DEF_KEY_` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `ROOT_PROC_INST_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `CREATE_TIME_` timestamp NOT NULL,
  `END_TIME_` timestamp NULL DEFAULT NULL,
  `INCIDENT_MSG_` varchar(4000) COLLATE utf8mb3_bin DEFAULT NULL,
  `INCIDENT_TYPE_` varchar(255) COLLATE utf8mb3_bin NOT NULL,
  `ACTIVITY_ID_` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `FAILED_ACTIVITY_ID_` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `CAUSE_INCIDENT_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `ROOT_CAUSE_INCIDENT_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `CONFIGURATION_` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `HISTORY_CONFIGURATION_` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `INCIDENT_STATE_` int DEFAULT NULL,
  `TENANT_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `JOB_DEF_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `ANNOTATION_` varchar(4000) COLLATE utf8mb3_bin DEFAULT NULL,
  `REMOVAL_TIME_` datetime DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_HI_INCIDENT_TENANT_ID` (`TENANT_ID_`),
  KEY `ACT_IDX_HI_INCIDENT_PROC_DEF_KEY` (`PROC_DEF_KEY_`),
  KEY `ACT_IDX_HI_INCIDENT_ROOT_PI` (`ROOT_PROC_INST_ID_`),
  KEY `ACT_IDX_HI_INCIDENT_PROCINST` (`PROC_INST_ID_`),
  KEY `ACT_IDX_HI_INCIDENT_RM_TIME` (`REMOVAL_TIME_`),
  KEY `ACT_IDX_HI_INCIDENT_CREATE_TIME` (`CREATE_TIME_`),
  KEY `ACT_IDX_HI_INCIDENT_END_TIME` (`END_TIME_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_hi_incident`
--

LOCK TABLES `act_hi_incident` WRITE;
/*!40000 ALTER TABLE `act_hi_incident` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_hi_incident` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_hi_job_log`
--

DROP TABLE IF EXISTS `act_hi_job_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `act_hi_job_log` (
  `ID_` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `TIMESTAMP_` datetime NOT NULL,
  `JOB_ID_` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `JOB_DUEDATE_` datetime DEFAULT NULL,
  `JOB_RETRIES_` int DEFAULT NULL,
  `JOB_PRIORITY_` bigint NOT NULL DEFAULT '0',
  `JOB_EXCEPTION_MSG_` varchar(4000) COLLATE utf8mb3_bin DEFAULT NULL,
  `JOB_EXCEPTION_STACK_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `JOB_STATE_` int DEFAULT NULL,
  `JOB_DEF_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `JOB_DEF_TYPE_` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `JOB_DEF_CONFIGURATION_` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `ACT_ID_` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `FAILED_ACT_ID_` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `ROOT_PROC_INST_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `PROCESS_INSTANCE_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `PROCESS_DEF_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `PROCESS_DEF_KEY_` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `DEPLOYMENT_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `SEQUENCE_COUNTER_` bigint DEFAULT NULL,
  `TENANT_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `HOSTNAME_` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `REMOVAL_TIME_` datetime DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_HI_JOB_LOG_ROOT_PI` (`ROOT_PROC_INST_ID_`),
  KEY `ACT_IDX_HI_JOB_LOG_PROCINST` (`PROCESS_INSTANCE_ID_`),
  KEY `ACT_IDX_HI_JOB_LOG_PROCDEF` (`PROCESS_DEF_ID_`),
  KEY `ACT_IDX_HI_JOB_LOG_TENANT_ID` (`TENANT_ID_`),
  KEY `ACT_IDX_HI_JOB_LOG_JOB_DEF_ID` (`JOB_DEF_ID_`),
  KEY `ACT_IDX_HI_JOB_LOG_PROC_DEF_KEY` (`PROCESS_DEF_KEY_`),
  KEY `ACT_IDX_HI_JOB_LOG_EX_STACK` (`JOB_EXCEPTION_STACK_ID_`),
  KEY `ACT_IDX_HI_JOB_LOG_RM_TIME` (`REMOVAL_TIME_`),
  KEY `ACT_IDX_HI_JOB_LOG_JOB_CONF` (`JOB_DEF_CONFIGURATION_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_hi_job_log`
--

LOCK TABLES `act_hi_job_log` WRITE;
/*!40000 ALTER TABLE `act_hi_job_log` DISABLE KEYS */;
INSERT INTO `act_hi_job_log` VALUES ('6f99a845-4eed-11ed-8d77-ec2e98f6b919','2022-10-18 16:02:00','6f995a24-4eed-11ed-8d77-ec2e98f6b919','2022-10-18 16:02:15',3,0,NULL,NULL,0,'66d64f4d-4eed-11ed-8d77-ec2e98f6b919','timer-transition','CYCLE: R1/PT15S','Event_12fcodo',NULL,'6f9848b2-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919','Process_Fogorvos:2:66d6283c-4eed-11ed-8d77-ec2e98f6b919','Process_Fogorvos','66c5113a-4eed-11ed-8d77-ec2e98f6b919',1,NULL,'192.168.99.56$default',NULL),('7bc643de-4eed-11ed-8d77-ec2e98f6b919','2022-10-18 16:02:21','6f995a24-4eed-11ed-8d77-ec2e98f6b919','2022-10-18 16:02:15',3,0,NULL,NULL,2,'66d64f4d-4eed-11ed-8d77-ec2e98f6b919','timer-transition','CYCLE: R1/PT15S','Event_12fcodo',NULL,'6f9848b2-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919','Process_Fogorvos:2:66d6283c-4eed-11ed-8d77-ec2e98f6b919','Process_Fogorvos','66c5113a-4eed-11ed-8d77-ec2e98f6b919',4,NULL,'192.168.99.56$default',NULL),('7f06a1d5-4eed-11ed-8d77-ec2e98f6b919','2022-10-18 16:02:26','7f06a1d4-4eed-11ed-8d77-ec2e98f6b919','2022-10-18 16:02:41',3,0,NULL,NULL,0,'66d64f4d-4eed-11ed-8d77-ec2e98f6b919','timer-transition','CYCLE: R1/PT15S','Event_12fcodo',NULL,'7f0653b2-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919','Process_Fogorvos:2:66d6283c-4eed-11ed-8d77-ec2e98f6b919','Process_Fogorvos','66c5113a-4eed-11ed-8d77-ec2e98f6b919',1,NULL,'192.168.99.56$default',NULL),('8e0485db-4eed-11ed-8d77-ec2e98f6b919','2022-10-18 16:02:52','7f06a1d4-4eed-11ed-8d77-ec2e98f6b919','2022-10-18 16:02:41',3,0,NULL,NULL,3,'66d64f4d-4eed-11ed-8d77-ec2e98f6b919','timer-transition','CYCLE: R1/PT15S','Event_12fcodo',NULL,'7f0653b2-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919','Process_Fogorvos:2:66d6283c-4eed-11ed-8d77-ec2e98f6b919','Process_Fogorvos','66c5113a-4eed-11ed-8d77-ec2e98f6b919',2,NULL,'192.168.99.56$default',NULL),('93d60047-4eeb-11ed-a18b-ec2e98f6b919','2022-10-18 15:48:42','93d5d936-4eeb-11ed-a18b-ec2e98f6b919','2022-10-18 15:58:42',3,0,NULL,NULL,0,'88fc727d-4eeb-11ed-a18b-ec2e98f6b919','timer-transition','CYCLE: R1/PT600S','Event_12fcodo',NULL,'93d53cf4-4eeb-11ed-a18b-ec2e98f6b919','93d38f30-4eeb-11ed-a18b-ec2e98f6b919','93d38f30-4eeb-11ed-a18b-ec2e98f6b919','Process_Fogorvos:1:88fc727c-4eeb-11ed-a18b-ec2e98f6b919','Process_Fogorvos','88ec1eca-4eeb-11ed-a18b-ec2e98f6b919',1,NULL,'192.168.99.56$default',NULL),('9a88efbd-4eeb-11ed-a18b-ec2e98f6b919','2022-10-18 15:48:54','93d5d936-4eeb-11ed-a18b-ec2e98f6b919','2022-10-18 15:58:42',3,0,NULL,NULL,3,'88fc727d-4eeb-11ed-a18b-ec2e98f6b919','timer-transition','CYCLE: R1/PT600S','Event_12fcodo',NULL,'93d53cf4-4eeb-11ed-a18b-ec2e98f6b919','93d38f30-4eeb-11ed-a18b-ec2e98f6b919','93d38f30-4eeb-11ed-a18b-ec2e98f6b919','Process_Fogorvos:1:88fc727c-4eeb-11ed-a18b-ec2e98f6b919','Process_Fogorvos','88ec1eca-4eeb-11ed-a18b-ec2e98f6b919',2,NULL,'192.168.99.56$default',NULL);
/*!40000 ALTER TABLE `act_hi_job_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_hi_op_log`
--

DROP TABLE IF EXISTS `act_hi_op_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `act_hi_op_log` (
  `ID_` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `DEPLOYMENT_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `PROC_DEF_KEY_` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `ROOT_PROC_INST_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `CASE_DEF_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `CASE_INST_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `CASE_EXECUTION_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `JOB_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `JOB_DEF_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `BATCH_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `USER_ID_` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `TIMESTAMP_` timestamp NOT NULL,
  `OPERATION_TYPE_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `OPERATION_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `ENTITY_TYPE_` varchar(30) COLLATE utf8mb3_bin DEFAULT NULL,
  `PROPERTY_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `ORG_VALUE_` varchar(4000) COLLATE utf8mb3_bin DEFAULT NULL,
  `NEW_VALUE_` varchar(4000) COLLATE utf8mb3_bin DEFAULT NULL,
  `TENANT_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `REMOVAL_TIME_` datetime DEFAULT NULL,
  `CATEGORY_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `EXTERNAL_TASK_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `ANNOTATION_` varchar(4000) COLLATE utf8mb3_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_HI_OP_LOG_ROOT_PI` (`ROOT_PROC_INST_ID_`),
  KEY `ACT_IDX_HI_OP_LOG_PROCINST` (`PROC_INST_ID_`),
  KEY `ACT_IDX_HI_OP_LOG_PROCDEF` (`PROC_DEF_ID_`),
  KEY `ACT_IDX_HI_OP_LOG_TASK` (`TASK_ID_`),
  KEY `ACT_IDX_HI_OP_LOG_RM_TIME` (`REMOVAL_TIME_`),
  KEY `ACT_IDX_HI_OP_LOG_TIMESTAMP` (`TIMESTAMP_`),
  KEY `ACT_IDX_HI_OP_LOG_USER_ID` (`USER_ID_`),
  KEY `ACT_IDX_HI_OP_LOG_OP_TYPE` (`OPERATION_TYPE_`),
  KEY `ACT_IDX_HI_OP_LOG_ENTITY_TYPE` (`ENTITY_TYPE_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_hi_op_log`
--

LOCK TABLES `act_hi_op_log` WRITE;
/*!40000 ALTER TABLE `act_hi_op_log` DISABLE KEYS */;
INSERT INTO `act_hi_op_log` VALUES ('50d55fb3-4eed-11ed-a18b-ec2e98f6b919','88ec1eca-4eeb-11ed-a18b-ec2e98f6b919','Process_Fogorvos:1:88fc727c-4eeb-11ed-a18b-ec2e98f6b919','Process_Fogorvos','93d38f30-4eeb-11ed-a18b-ec2e98f6b919','93d38f30-4eeb-11ed-a18b-ec2e98f6b919','93d38f30-4eeb-11ed-a18b-ec2e98f6b919',NULL,NULL,NULL,'9a8916cf-4eeb-11ed-a18b-ec2e98f6b919',NULL,NULL,NULL,'fogorvosdemo','2022-10-18 14:01:09','Complete','50d55fb2-4eed-11ed-a18b-ec2e98f6b919','Task','delete','false','true',NULL,NULL,'TaskWorker',NULL,NULL),('7f054240-4eed-11ed-8d77-ec2e98f6b919','66c5113a-4eed-11ed-8d77-ec2e98f6b919','Process_Fogorvos:2:66d6283c-4eed-11ed-8d77-ec2e98f6b919','Process_Fogorvos','6f964cce-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919',NULL,NULL,NULL,'7bc5a79b-4eed-11ed-8d77-ec2e98f6b919',NULL,NULL,NULL,'fogorvosdemo','2022-10-18 14:02:26','Complete','7f051b2f-4eed-11ed-8d77-ec2e98f6b919','Task','delete','false','true',NULL,NULL,'TaskWorker',NULL,NULL),('8e039b7a-4eed-11ed-8d77-ec2e98f6b919','66c5113a-4eed-11ed-8d77-ec2e98f6b919','Process_Fogorvos:2:66d6283c-4eed-11ed-8d77-ec2e98f6b919','Process_Fogorvos','6f964cce-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919','7f0653b2-4eed-11ed-8d77-ec2e98f6b919',NULL,NULL,NULL,'7f06a1d6-4eed-11ed-8d77-ec2e98f6b919',NULL,NULL,NULL,'fogorvosdemo','2022-10-18 14:02:52','Complete','8e039b79-4eed-11ed-8d77-ec2e98f6b919','Task','delete','false','true',NULL,NULL,'TaskWorker',NULL,NULL),('8e5a0b1f-4eeb-11ed-a18b-ec2e98f6b919',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'fogorvosdemo','2022-10-18 13:48:33','Update','8e5a0b1e-4eeb-11ed-a18b-ec2e98f6b919','Property','name',NULL,'camunda.telemetry.enabled',NULL,NULL,'Admin',NULL,NULL),('8f300d91-4eed-11ed-8d77-ec2e98f6b919','66c5113a-4eed-11ed-8d77-ec2e98f6b919','Process_Fogorvos:2:66d6283c-4eed-11ed-8d77-ec2e98f6b919','Process_Fogorvos','6f964cce-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919',NULL,NULL,NULL,'8e04aced-4eed-11ed-8d77-ec2e98f6b919',NULL,NULL,NULL,'fogorvosdemo','2022-10-18 14:02:53','Complete','8f300d90-4eed-11ed-8d77-ec2e98f6b919','Task','delete','false','true',NULL,NULL,'TaskWorker',NULL,NULL),('90171238-4eed-11ed-8d77-ec2e98f6b919','66c5113a-4eed-11ed-8d77-ec2e98f6b919','Process_Fogorvos:2:66d6283c-4eed-11ed-8d77-ec2e98f6b919','Process_Fogorvos','6f964cce-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919',NULL,NULL,NULL,'8f30f7f4-4eed-11ed-8d77-ec2e98f6b919',NULL,NULL,NULL,'fogorvosdemo','2022-10-18 14:02:55','Complete','90171237-4eed-11ed-8d77-ec2e98f6b919','Task','delete','false','true',NULL,NULL,'TaskWorker',NULL,NULL),('91187cae-4eed-11ed-8d77-ec2e98f6b919','66c5113a-4eed-11ed-8d77-ec2e98f6b919','Process_Fogorvos:2:66d6283c-4eed-11ed-8d77-ec2e98f6b919','Process_Fogorvos','6f964cce-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919',NULL,NULL,NULL,'9017ae7a-4eed-11ed-8d77-ec2e98f6b919',NULL,NULL,NULL,'fogorvosdemo','2022-10-18 14:02:57','Complete','91187cad-4eed-11ed-8d77-ec2e98f6b919','Task','delete','false','true',NULL,NULL,'TaskWorker',NULL,NULL),('91e43125-4eed-11ed-8d77-ec2e98f6b919','66c5113a-4eed-11ed-8d77-ec2e98f6b919','Process_Fogorvos:2:66d6283c-4eed-11ed-8d77-ec2e98f6b919','Process_Fogorvos','6f964cce-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919',NULL,NULL,NULL,'91196711-4eed-11ed-8d77-ec2e98f6b919',NULL,NULL,NULL,'fogorvosdemo','2022-10-18 14:02:58','Complete','91e43124-4eed-11ed-8d77-ec2e98f6b919','Task','delete','false','true',NULL,NULL,'TaskWorker',NULL,NULL),('9a87420c-4eeb-11ed-a18b-ec2e98f6b919','88ec1eca-4eeb-11ed-a18b-ec2e98f6b919','Process_Fogorvos:1:88fc727c-4eeb-11ed-a18b-ec2e98f6b919','Process_Fogorvos','93d38f30-4eeb-11ed-a18b-ec2e98f6b919','93d38f30-4eeb-11ed-a18b-ec2e98f6b919','93d53cf4-4eeb-11ed-a18b-ec2e98f6b919',NULL,NULL,NULL,'93d62758-4eeb-11ed-a18b-ec2e98f6b919',NULL,NULL,NULL,'fogorvosdemo','2022-10-18 13:48:54','Complete','9a87420b-4eeb-11ed-a18b-ec2e98f6b919','Task','delete','false','true',NULL,NULL,'TaskWorker',NULL,NULL),('a12eae8a-4eed-11ed-8d77-ec2e98f6b919','88ec1eca-4eeb-11ed-a18b-ec2e98f6b919',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'fogorvosdemo','2022-10-18 14:03:24','Delete','a12eae89-4eed-11ed-8d77-ec2e98f6b919','Deployment','cascade',NULL,'false',NULL,NULL,'Operator',NULL,NULL);
/*!40000 ALTER TABLE `act_hi_op_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_hi_procinst`
--

DROP TABLE IF EXISTS `act_hi_procinst`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `act_hi_procinst` (
  `ID_` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `BUSINESS_KEY_` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `PROC_DEF_KEY_` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `START_TIME_` datetime NOT NULL,
  `END_TIME_` datetime DEFAULT NULL,
  `REMOVAL_TIME_` datetime DEFAULT NULL,
  `DURATION_` bigint DEFAULT NULL,
  `START_USER_ID_` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `START_ACT_ID_` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `END_ACT_ID_` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `SUPER_PROCESS_INSTANCE_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `ROOT_PROC_INST_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `SUPER_CASE_INSTANCE_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `CASE_INST_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `DELETE_REASON_` varchar(4000) COLLATE utf8mb3_bin DEFAULT NULL,
  `TENANT_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `STATE_` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  UNIQUE KEY `PROC_INST_ID_` (`PROC_INST_ID_`),
  KEY `ACT_IDX_HI_PRO_INST_END` (`END_TIME_`),
  KEY `ACT_IDX_HI_PRO_I_BUSKEY` (`BUSINESS_KEY_`),
  KEY `ACT_IDX_HI_PRO_INST_TENANT_ID` (`TENANT_ID_`),
  KEY `ACT_IDX_HI_PRO_INST_PROC_DEF_KEY` (`PROC_DEF_KEY_`),
  KEY `ACT_IDX_HI_PRO_INST_PROC_TIME` (`START_TIME_`,`END_TIME_`),
  KEY `ACT_IDX_HI_PI_PDEFID_END_TIME` (`PROC_DEF_ID_`,`END_TIME_`),
  KEY `ACT_IDX_HI_PRO_INST_ROOT_PI` (`ROOT_PROC_INST_ID_`),
  KEY `ACT_IDX_HI_PRO_INST_RM_TIME` (`REMOVAL_TIME_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_hi_procinst`
--

LOCK TABLES `act_hi_procinst` WRITE;
/*!40000 ALTER TABLE `act_hi_procinst` DISABLE KEYS */;
INSERT INTO `act_hi_procinst` VALUES ('6f964cce-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919',NULL,'Process_Fogorvos','Process_Fogorvos:2:66d6283c-4eed-11ed-8d77-ec2e98f6b919','2022-10-18 16:02:00','2022-10-18 16:02:58',NULL,58030,NULL,'StartEvent_1','EndEvent_1',NULL,'6f964cce-4eed-11ed-8d77-ec2e98f6b919',NULL,NULL,NULL,NULL,'COMPLETED'),('93d38f30-4eeb-11ed-a18b-ec2e98f6b919','93d38f30-4eeb-11ed-a18b-ec2e98f6b919',NULL,'Process_Fogorvos','Process_Fogorvos:1:88fc727c-4eeb-11ed-a18b-ec2e98f6b919','2022-10-18 15:48:42','2022-10-18 16:01:09',NULL,746884,NULL,'StartEvent_1','EndEvent_1',NULL,'93d38f30-4eeb-11ed-a18b-ec2e98f6b919',NULL,NULL,NULL,NULL,'COMPLETED');
/*!40000 ALTER TABLE `act_hi_procinst` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_hi_taskinst`
--

DROP TABLE IF EXISTS `act_hi_taskinst`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `act_hi_taskinst` (
  `ID_` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `TASK_DEF_KEY_` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `PROC_DEF_KEY_` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `ROOT_PROC_INST_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `CASE_DEF_KEY_` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `CASE_DEF_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `CASE_INST_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `CASE_EXECUTION_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `ACT_INST_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `PARENT_TASK_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `DESCRIPTION_` varchar(4000) COLLATE utf8mb3_bin DEFAULT NULL,
  `OWNER_` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `ASSIGNEE_` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `START_TIME_` datetime NOT NULL,
  `END_TIME_` datetime DEFAULT NULL,
  `DURATION_` bigint DEFAULT NULL,
  `DELETE_REASON_` varchar(4000) COLLATE utf8mb3_bin DEFAULT NULL,
  `PRIORITY_` int DEFAULT NULL,
  `DUE_DATE_` datetime DEFAULT NULL,
  `FOLLOW_UP_DATE_` datetime DEFAULT NULL,
  `TENANT_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `REMOVAL_TIME_` datetime DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_HI_TASKINST_ROOT_PI` (`ROOT_PROC_INST_ID_`),
  KEY `ACT_IDX_HI_TASK_INST_TENANT_ID` (`TENANT_ID_`),
  KEY `ACT_IDX_HI_TASK_INST_PROC_DEF_KEY` (`PROC_DEF_KEY_`),
  KEY `ACT_IDX_HI_TASKINST_PROCINST` (`PROC_INST_ID_`),
  KEY `ACT_IDX_HI_TASKINSTID_PROCINST` (`ID_`,`PROC_INST_ID_`),
  KEY `ACT_IDX_HI_TASK_INST_RM_TIME` (`REMOVAL_TIME_`),
  KEY `ACT_IDX_HI_TASK_INST_START` (`START_TIME_`),
  KEY `ACT_IDX_HI_TASK_INST_END` (`END_TIME_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_hi_taskinst`
--

LOCK TABLES `act_hi_taskinst` WRITE;
/*!40000 ALTER TABLE `act_hi_taskinst` DISABLE KEYS */;
INSERT INTO `act_hi_taskinst` VALUES ('6f99cf56-4eed-11ed-8d77-ec2e98f6b919','Activity_MegjelenesIdoponton','Process_Fogorvos','Process_Fogorvos:2:66d6283c-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919','6f9848b2-4eed-11ed-8d77-ec2e98f6b919',NULL,NULL,NULL,NULL,'6f9848b3-4eed-11ed-8d77-ec2e98f6b919','Megjelenés az időponton',NULL,NULL,NULL,'fogorvosdemo','2022-10-18 16:02:00','2022-10-18 16:02:21',20908,'deleted',50,NULL,NULL,NULL,NULL),('7bc5a79b-4eed-11ed-8d77-ec2e98f6b919','Activity_BetegErtesitese','Process_Fogorvos','Process_Fogorvos:2:66d6283c-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919',NULL,NULL,NULL,NULL,'Activity_BetegErtesitese:7bc5a79a-4eed-11ed-8d77-ec2e98f6b919','Beteg értesítése',NULL,NULL,NULL,'fogorvosdemo','2022-10-18 16:02:21','2022-10-18 16:02:26',5365,'completed',50,NULL,NULL,NULL,NULL),('7f06a1d6-4eed-11ed-8d77-ec2e98f6b919','Activity_MegjelenesIdoponton','Process_Fogorvos','Process_Fogorvos:2:66d6283c-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919','7f0653b2-4eed-11ed-8d77-ec2e98f6b919',NULL,NULL,NULL,NULL,'7f067ac3-4eed-11ed-8d77-ec2e98f6b919','Megjelenés az időponton',NULL,NULL,NULL,'fogorvosdemo','2022-10-18 16:02:26','2022-10-18 16:02:52',25519,'completed',50,NULL,NULL,NULL,NULL),('8e04aced-4eed-11ed-8d77-ec2e98f6b919','Activity_Vizsgalat','Process_Fogorvos','Process_Fogorvos:2:66d6283c-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919',NULL,NULL,NULL,NULL,'Activity_Vizsgalat:8e04acec-4eed-11ed-8d77-ec2e98f6b919','Vizsgálat',NULL,NULL,NULL,'fogorvosdemo','2022-10-18 16:02:52','2022-10-18 16:02:53',1488,'completed',50,NULL,NULL,NULL,NULL),('8f30f7f4-4eed-11ed-8d77-ec2e98f6b919','Activity_Rontgen','Process_Fogorvos','Process_Fogorvos:2:66d6283c-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919',NULL,NULL,NULL,NULL,'Activity_Rontgen:8f30f7f3-4eed-11ed-8d77-ec2e98f6b919','Röntgen',NULL,NULL,NULL,'fogorvosdemo','2022-10-18 16:02:53','2022-10-18 16:02:55',2002,'completed',50,NULL,NULL,NULL,NULL),('9017ae7a-4eed-11ed-8d77-ec2e98f6b919','Activity_0fx95tn','Process_Fogorvos','Process_Fogorvos:2:66d6283c-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919',NULL,NULL,NULL,NULL,'Activity_0fx95tn:9017ae79-4eed-11ed-8d77-ec2e98f6b919','Felülvizsgálat',NULL,NULL,NULL,'fogorvosdemo','2022-10-18 16:02:55','2022-10-18 16:02:57',1689,'completed',50,NULL,NULL,NULL,NULL),('91196711-4eed-11ed-8d77-ec2e98f6b919','Activity_0f6etab','Process_Fogorvos','Process_Fogorvos:2:66d6283c-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919',NULL,NULL,NULL,NULL,'Activity_0f6etab:91196710-4eed-11ed-8d77-ec2e98f6b919','Szakorvosi vizsgálat',NULL,NULL,NULL,'fogorvosdemo','2022-10-18 16:02:57','2022-10-18 16:02:58',1024,'completed',50,NULL,NULL,NULL,NULL),('93d62758-4eeb-11ed-a18b-ec2e98f6b919','Activity_MegjelenesIdoponton','Process_Fogorvos','Process_Fogorvos:1:88fc727c-4eeb-11ed-a18b-ec2e98f6b919','93d38f30-4eeb-11ed-a18b-ec2e98f6b919','93d38f30-4eeb-11ed-a18b-ec2e98f6b919','93d53cf4-4eeb-11ed-a18b-ec2e98f6b919',NULL,NULL,NULL,NULL,'93d53cf5-4eeb-11ed-a18b-ec2e98f6b919','Megjelenés az időponton',NULL,NULL,NULL,'fogorvosdemo','2022-10-18 15:48:42','2022-10-18 15:48:54',11523,'completed',50,NULL,NULL,NULL,NULL),('9a8916cf-4eeb-11ed-a18b-ec2e98f6b919','Activity_Vizsgalat','Process_Fogorvos','Process_Fogorvos:1:88fc727c-4eeb-11ed-a18b-ec2e98f6b919','93d38f30-4eeb-11ed-a18b-ec2e98f6b919','93d38f30-4eeb-11ed-a18b-ec2e98f6b919','93d38f30-4eeb-11ed-a18b-ec2e98f6b919',NULL,NULL,NULL,NULL,'Activity_Vizsgalat:9a8916ce-4eeb-11ed-a18b-ec2e98f6b919','Vizsgálat',NULL,NULL,NULL,'fogorvosdemo','2022-10-18 15:48:54','2022-10-18 16:01:09',734875,'completed',50,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `act_hi_taskinst` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_hi_varinst`
--

DROP TABLE IF EXISTS `act_hi_varinst`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `act_hi_varinst` (
  `ID_` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `PROC_DEF_KEY_` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `ROOT_PROC_INST_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `ACT_INST_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `CASE_DEF_KEY_` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `CASE_DEF_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `CASE_INST_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `CASE_EXECUTION_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8mb3_bin NOT NULL,
  `VAR_TYPE_` varchar(100) COLLATE utf8mb3_bin DEFAULT NULL,
  `CREATE_TIME_` datetime DEFAULT NULL,
  `REV_` int DEFAULT NULL,
  `BYTEARRAY_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `DOUBLE_` double DEFAULT NULL,
  `LONG_` bigint DEFAULT NULL,
  `TEXT_` varchar(4000) COLLATE utf8mb3_bin DEFAULT NULL,
  `TEXT2_` varchar(4000) COLLATE utf8mb3_bin DEFAULT NULL,
  `TENANT_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `STATE_` varchar(20) COLLATE utf8mb3_bin DEFAULT NULL,
  `REMOVAL_TIME_` datetime DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_HI_VARINST_ROOT_PI` (`ROOT_PROC_INST_ID_`),
  KEY `ACT_IDX_HI_PROCVAR_PROC_INST` (`PROC_INST_ID_`),
  KEY `ACT_IDX_HI_PROCVAR_NAME_TYPE` (`NAME_`,`VAR_TYPE_`),
  KEY `ACT_IDX_HI_CASEVAR_CASE_INST` (`CASE_INST_ID_`),
  KEY `ACT_IDX_HI_VAR_INST_TENANT_ID` (`TENANT_ID_`),
  KEY `ACT_IDX_HI_VAR_INST_PROC_DEF_KEY` (`PROC_DEF_KEY_`),
  KEY `ACT_IDX_HI_VARINST_BYTEAR` (`BYTEARRAY_ID_`),
  KEY `ACT_IDX_HI_VARINST_RM_TIME` (`REMOVAL_TIME_`),
  KEY `ACT_IDX_HI_VAR_PI_NAME_TYPE` (`PROC_INST_ID_`,`NAME_`,`VAR_TYPE_`),
  KEY `ACT_IDX_HI_VARINST_NAME` (`NAME_`),
  KEY `ACT_IDX_HI_VARINST_ACT_INST_ID` (`ACT_INST_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_hi_varinst`
--

LOCK TABLES `act_hi_varinst` WRITE;
/*!40000 ALTER TABLE `act_hi_varinst` DISABLE KEYS */;
INSERT INTO `act_hi_varinst` VALUES ('6f97101f-4eed-11ed-8d77-ec2e98f6b919','Process_Fogorvos','Process_Fogorvos:2:66d6283c-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919',NULL,NULL,NULL,NULL,NULL,'fogszabalyzo','boolean','2022-10-18 16:02:00',0,NULL,NULL,0,NULL,NULL,NULL,'CREATED',NULL),('6f973731-4eed-11ed-8d77-ec2e98f6b919','Process_Fogorvos','Process_Fogorvos:2:66d6283c-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919',NULL,NULL,NULL,NULL,NULL,'szakorvos','string','2022-10-18 16:02:00',0,NULL,NULL,NULL,'fogorvosdemo',NULL,NULL,'CREATED',NULL),('6f973733-4eed-11ed-8d77-ec2e98f6b919','Process_Fogorvos','Process_Fogorvos:2:66d6283c-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919',NULL,NULL,NULL,NULL,NULL,'elmarad','boolean','2022-10-18 16:02:00',0,NULL,NULL,0,NULL,NULL,NULL,'CREATED',NULL),('6f973735-4eed-11ed-8d77-ec2e98f6b919','Process_Fogorvos','Process_Fogorvos:2:66d6283c-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919',NULL,NULL,NULL,NULL,NULL,'orvos','string','2022-10-18 16:02:00',0,NULL,NULL,NULL,'fogorvosdemo',NULL,NULL,'CREATED',NULL),('6f973737-4eed-11ed-8d77-ec2e98f6b919','Process_Fogorvos','Process_Fogorvos:2:66d6283c-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919',NULL,NULL,NULL,NULL,NULL,'beteg','string','2022-10-18 16:02:00',0,NULL,NULL,NULL,'fogorvosdemo',NULL,NULL,'CREATED',NULL),('6f975e49-4eed-11ed-8d77-ec2e98f6b919','Process_Fogorvos','Process_Fogorvos:2:66d6283c-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919',NULL,NULL,NULL,NULL,NULL,'rontgen','boolean','2022-10-18 16:02:00',0,NULL,NULL,1,NULL,NULL,NULL,'CREATED',NULL),('6f975e4b-4eed-11ed-8d77-ec2e98f6b919','Process_Fogorvos','Process_Fogorvos:2:66d6283c-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919',NULL,NULL,NULL,NULL,NULL,'szakorvosiVizsgalat','boolean','2022-10-18 16:02:00',0,NULL,NULL,1,NULL,NULL,NULL,'CREATED',NULL),('6f975e4d-4eed-11ed-8d77-ec2e98f6b919','Process_Fogorvos','Process_Fogorvos:2:66d6283c-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919',NULL,NULL,NULL,NULL,NULL,'rontgenes','string','2022-10-18 16:02:00',0,NULL,NULL,NULL,'fogorvosdemo',NULL,NULL,'CREATED',NULL),('6f975e4f-4eed-11ed-8d77-ec2e98f6b919','Process_Fogorvos','Process_Fogorvos:2:66d6283c-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919','6f964cce-4eed-11ed-8d77-ec2e98f6b919',NULL,NULL,NULL,NULL,NULL,'recepcios','string','2022-10-18 16:02:00',0,NULL,NULL,NULL,'fogorvosdemo',NULL,NULL,'CREATED',NULL),('93d40461-4eeb-11ed-a18b-ec2e98f6b919','Process_Fogorvos','Process_Fogorvos:1:88fc727c-4eeb-11ed-a18b-ec2e98f6b919','93d38f30-4eeb-11ed-a18b-ec2e98f6b919','93d38f30-4eeb-11ed-a18b-ec2e98f6b919','93d38f30-4eeb-11ed-a18b-ec2e98f6b919','93d38f30-4eeb-11ed-a18b-ec2e98f6b919',NULL,NULL,NULL,NULL,NULL,'fogszabalyzo','boolean','2022-10-18 15:48:42',0,NULL,NULL,0,NULL,NULL,NULL,'CREATED',NULL),('93d40463-4eeb-11ed-a18b-ec2e98f6b919','Process_Fogorvos','Process_Fogorvos:1:88fc727c-4eeb-11ed-a18b-ec2e98f6b919','93d38f30-4eeb-11ed-a18b-ec2e98f6b919','93d38f30-4eeb-11ed-a18b-ec2e98f6b919','93d38f30-4eeb-11ed-a18b-ec2e98f6b919','93d38f30-4eeb-11ed-a18b-ec2e98f6b919',NULL,NULL,NULL,NULL,NULL,'szakorvos','string','2022-10-18 15:48:42',0,NULL,NULL,NULL,'fogorvosdemo',NULL,NULL,'CREATED',NULL),('93d42b75-4eeb-11ed-a18b-ec2e98f6b919','Process_Fogorvos','Process_Fogorvos:1:88fc727c-4eeb-11ed-a18b-ec2e98f6b919','93d38f30-4eeb-11ed-a18b-ec2e98f6b919','93d38f30-4eeb-11ed-a18b-ec2e98f6b919','93d38f30-4eeb-11ed-a18b-ec2e98f6b919','93d38f30-4eeb-11ed-a18b-ec2e98f6b919',NULL,NULL,NULL,NULL,NULL,'elmarad','boolean','2022-10-18 15:48:42',0,NULL,NULL,0,NULL,NULL,NULL,'CREATED',NULL),('93d42b77-4eeb-11ed-a18b-ec2e98f6b919','Process_Fogorvos','Process_Fogorvos:1:88fc727c-4eeb-11ed-a18b-ec2e98f6b919','93d38f30-4eeb-11ed-a18b-ec2e98f6b919','93d38f30-4eeb-11ed-a18b-ec2e98f6b919','93d38f30-4eeb-11ed-a18b-ec2e98f6b919','93d38f30-4eeb-11ed-a18b-ec2e98f6b919',NULL,NULL,NULL,NULL,NULL,'orvos','string','2022-10-18 15:48:42',0,NULL,NULL,NULL,'fogorvosdemo',NULL,NULL,'CREATED',NULL),('93d42b79-4eeb-11ed-a18b-ec2e98f6b919','Process_Fogorvos','Process_Fogorvos:1:88fc727c-4eeb-11ed-a18b-ec2e98f6b919','93d38f30-4eeb-11ed-a18b-ec2e98f6b919','93d38f30-4eeb-11ed-a18b-ec2e98f6b919','93d38f30-4eeb-11ed-a18b-ec2e98f6b919','93d38f30-4eeb-11ed-a18b-ec2e98f6b919',NULL,NULL,NULL,NULL,NULL,'beteg','string','2022-10-18 15:48:42',0,NULL,NULL,NULL,'fogorvosdemo',NULL,NULL,'CREATED',NULL),('93d42b7b-4eeb-11ed-a18b-ec2e98f6b919','Process_Fogorvos','Process_Fogorvos:1:88fc727c-4eeb-11ed-a18b-ec2e98f6b919','93d38f30-4eeb-11ed-a18b-ec2e98f6b919','93d38f30-4eeb-11ed-a18b-ec2e98f6b919','93d38f30-4eeb-11ed-a18b-ec2e98f6b919','93d38f30-4eeb-11ed-a18b-ec2e98f6b919',NULL,NULL,NULL,NULL,NULL,'rontgen','boolean','2022-10-18 15:48:42',0,NULL,NULL,0,NULL,NULL,NULL,'CREATED',NULL),('93d42b7d-4eeb-11ed-a18b-ec2e98f6b919','Process_Fogorvos','Process_Fogorvos:1:88fc727c-4eeb-11ed-a18b-ec2e98f6b919','93d38f30-4eeb-11ed-a18b-ec2e98f6b919','93d38f30-4eeb-11ed-a18b-ec2e98f6b919','93d38f30-4eeb-11ed-a18b-ec2e98f6b919','93d38f30-4eeb-11ed-a18b-ec2e98f6b919',NULL,NULL,NULL,NULL,NULL,'szakorvosiVizsgalat','boolean','2022-10-18 15:48:42',0,NULL,NULL,0,NULL,NULL,NULL,'CREATED',NULL),('93d42b7f-4eeb-11ed-a18b-ec2e98f6b919','Process_Fogorvos','Process_Fogorvos:1:88fc727c-4eeb-11ed-a18b-ec2e98f6b919','93d38f30-4eeb-11ed-a18b-ec2e98f6b919','93d38f30-4eeb-11ed-a18b-ec2e98f6b919','93d38f30-4eeb-11ed-a18b-ec2e98f6b919','93d38f30-4eeb-11ed-a18b-ec2e98f6b919',NULL,NULL,NULL,NULL,NULL,'rontgenes','string','2022-10-18 15:48:42',0,NULL,NULL,NULL,'fogorvosdemo',NULL,NULL,'CREATED',NULL),('93d42b81-4eeb-11ed-a18b-ec2e98f6b919','Process_Fogorvos','Process_Fogorvos:1:88fc727c-4eeb-11ed-a18b-ec2e98f6b919','93d38f30-4eeb-11ed-a18b-ec2e98f6b919','93d38f30-4eeb-11ed-a18b-ec2e98f6b919','93d38f30-4eeb-11ed-a18b-ec2e98f6b919','93d38f30-4eeb-11ed-a18b-ec2e98f6b919',NULL,NULL,NULL,NULL,NULL,'recepcios','string','2022-10-18 15:48:42',0,NULL,NULL,NULL,'fogorvosdemo',NULL,NULL,'CREATED',NULL);
/*!40000 ALTER TABLE `act_hi_varinst` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_id_group`
--

DROP TABLE IF EXISTS `act_id_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `act_id_group` (
  `ID_` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `REV_` int DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_id_group`
--

LOCK TABLES `act_id_group` WRITE;
/*!40000 ALTER TABLE `act_id_group` DISABLE KEYS */;
INSERT INTO `act_id_group` VALUES ('camunda-admin',1,'camunda BPM Administrators','SYSTEM');
/*!40000 ALTER TABLE `act_id_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_id_info`
--

DROP TABLE IF EXISTS `act_id_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `act_id_info` (
  `ID_` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `REV_` int DEFAULT NULL,
  `USER_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `TYPE_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `KEY_` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `VALUE_` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `PASSWORD_` longblob,
  `PARENT_ID_` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_id_info`
--

LOCK TABLES `act_id_info` WRITE;
/*!40000 ALTER TABLE `act_id_info` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_id_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_id_membership`
--

DROP TABLE IF EXISTS `act_id_membership`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `act_id_membership` (
  `USER_ID_` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `GROUP_ID_` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  PRIMARY KEY (`USER_ID_`,`GROUP_ID_`),
  KEY `ACT_FK_MEMB_GROUP` (`GROUP_ID_`),
  CONSTRAINT `ACT_FK_MEMB_GROUP` FOREIGN KEY (`GROUP_ID_`) REFERENCES `act_id_group` (`ID_`),
  CONSTRAINT `ACT_FK_MEMB_USER` FOREIGN KEY (`USER_ID_`) REFERENCES `act_id_user` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_id_membership`
--

LOCK TABLES `act_id_membership` WRITE;
/*!40000 ALTER TABLE `act_id_membership` DISABLE KEYS */;
INSERT INTO `act_id_membership` VALUES ('fogorvosdemo','camunda-admin');
/*!40000 ALTER TABLE `act_id_membership` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_id_tenant`
--

DROP TABLE IF EXISTS `act_id_tenant`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `act_id_tenant` (
  `ID_` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `REV_` int DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_id_tenant`
--

LOCK TABLES `act_id_tenant` WRITE;
/*!40000 ALTER TABLE `act_id_tenant` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_id_tenant` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_id_tenant_member`
--

DROP TABLE IF EXISTS `act_id_tenant_member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `act_id_tenant_member` (
  `ID_` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `TENANT_ID_` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `USER_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `GROUP_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  UNIQUE KEY `ACT_UNIQ_TENANT_MEMB_USER` (`TENANT_ID_`,`USER_ID_`),
  UNIQUE KEY `ACT_UNIQ_TENANT_MEMB_GROUP` (`TENANT_ID_`,`GROUP_ID_`),
  KEY `ACT_FK_TENANT_MEMB_USER` (`USER_ID_`),
  KEY `ACT_FK_TENANT_MEMB_GROUP` (`GROUP_ID_`),
  CONSTRAINT `ACT_FK_TENANT_MEMB` FOREIGN KEY (`TENANT_ID_`) REFERENCES `act_id_tenant` (`ID_`),
  CONSTRAINT `ACT_FK_TENANT_MEMB_GROUP` FOREIGN KEY (`GROUP_ID_`) REFERENCES `act_id_group` (`ID_`),
  CONSTRAINT `ACT_FK_TENANT_MEMB_USER` FOREIGN KEY (`USER_ID_`) REFERENCES `act_id_user` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_id_tenant_member`
--

LOCK TABLES `act_id_tenant_member` WRITE;
/*!40000 ALTER TABLE `act_id_tenant_member` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_id_tenant_member` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_id_user`
--

DROP TABLE IF EXISTS `act_id_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `act_id_user` (
  `ID_` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `REV_` int DEFAULT NULL,
  `FIRST_` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `LAST_` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `EMAIL_` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `PWD_` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `SALT_` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `LOCK_EXP_TIME_` datetime DEFAULT NULL,
  `ATTEMPTS_` int DEFAULT NULL,
  `PICTURE_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_id_user`
--

LOCK TABLES `act_id_user` WRITE;
/*!40000 ALTER TABLE `act_id_user` DISABLE KEYS */;
INSERT INTO `act_id_user` VALUES ('fogorvosdemo',1,'Demo','Fogorvosdemo','fogorvosdemo@localhost','{SHA-512}9J/A+DnA7CP6zhaLMzJddRIAUTKA6s+HaeIc1tmWQNd5s0prpkqmFMCobZtm1oC0Wv3zZ8MYIKoi/TY+HSQMmw==','2Eb3oJoIVkl7mSJAUgSzDw==',NULL,NULL,NULL);
/*!40000 ALTER TABLE `act_id_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_re_camformdef`
--

DROP TABLE IF EXISTS `act_re_camformdef`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `act_re_camformdef` (
  `ID_` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `REV_` int DEFAULT NULL,
  `KEY_` varchar(255) COLLATE utf8mb3_bin NOT NULL,
  `VERSION_` int NOT NULL,
  `DEPLOYMENT_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `RESOURCE_NAME_` varchar(4000) COLLATE utf8mb3_bin DEFAULT NULL,
  `TENANT_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_re_camformdef`
--

LOCK TABLES `act_re_camformdef` WRITE;
/*!40000 ALTER TABLE `act_re_camformdef` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_re_camformdef` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_re_case_def`
--

DROP TABLE IF EXISTS `act_re_case_def`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `act_re_case_def` (
  `ID_` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `REV_` int DEFAULT NULL,
  `CATEGORY_` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `KEY_` varchar(255) COLLATE utf8mb3_bin NOT NULL,
  `VERSION_` int NOT NULL,
  `DEPLOYMENT_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `RESOURCE_NAME_` varchar(4000) COLLATE utf8mb3_bin DEFAULT NULL,
  `DGRM_RESOURCE_NAME_` varchar(4000) COLLATE utf8mb3_bin DEFAULT NULL,
  `TENANT_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `HISTORY_TTL_` int DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_CASE_DEF_TENANT_ID` (`TENANT_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_re_case_def`
--

LOCK TABLES `act_re_case_def` WRITE;
/*!40000 ALTER TABLE `act_re_case_def` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_re_case_def` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_re_decision_def`
--

DROP TABLE IF EXISTS `act_re_decision_def`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `act_re_decision_def` (
  `ID_` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `REV_` int DEFAULT NULL,
  `CATEGORY_` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `KEY_` varchar(255) COLLATE utf8mb3_bin NOT NULL,
  `VERSION_` int NOT NULL,
  `DEPLOYMENT_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `RESOURCE_NAME_` varchar(4000) COLLATE utf8mb3_bin DEFAULT NULL,
  `DGRM_RESOURCE_NAME_` varchar(4000) COLLATE utf8mb3_bin DEFAULT NULL,
  `DEC_REQ_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `DEC_REQ_KEY_` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `TENANT_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `HISTORY_TTL_` int DEFAULT NULL,
  `VERSION_TAG_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_DEC_DEF_TENANT_ID` (`TENANT_ID_`),
  KEY `ACT_IDX_DEC_DEF_REQ_ID` (`DEC_REQ_ID_`),
  CONSTRAINT `ACT_FK_DEC_REQ` FOREIGN KEY (`DEC_REQ_ID_`) REFERENCES `act_re_decision_req_def` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_re_decision_def`
--

LOCK TABLES `act_re_decision_def` WRITE;
/*!40000 ALTER TABLE `act_re_decision_def` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_re_decision_def` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_re_decision_req_def`
--

DROP TABLE IF EXISTS `act_re_decision_req_def`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `act_re_decision_req_def` (
  `ID_` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `REV_` int DEFAULT NULL,
  `CATEGORY_` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `KEY_` varchar(255) COLLATE utf8mb3_bin NOT NULL,
  `VERSION_` int NOT NULL,
  `DEPLOYMENT_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `RESOURCE_NAME_` varchar(4000) COLLATE utf8mb3_bin DEFAULT NULL,
  `DGRM_RESOURCE_NAME_` varchar(4000) COLLATE utf8mb3_bin DEFAULT NULL,
  `TENANT_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_DEC_REQ_DEF_TENANT_ID` (`TENANT_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_re_decision_req_def`
--

LOCK TABLES `act_re_decision_req_def` WRITE;
/*!40000 ALTER TABLE `act_re_decision_req_def` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_re_decision_req_def` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_re_deployment`
--

DROP TABLE IF EXISTS `act_re_deployment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `act_re_deployment` (
  `ID_` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `NAME_` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `DEPLOY_TIME_` datetime DEFAULT NULL,
  `SOURCE_` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `TENANT_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_DEPLOYMENT_NAME` (`NAME_`),
  KEY `ACT_IDX_DEPLOYMENT_TENANT_ID` (`TENANT_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_re_deployment`
--

LOCK TABLES `act_re_deployment` WRITE;
/*!40000 ALTER TABLE `act_re_deployment` DISABLE KEYS */;
INSERT INTO `act_re_deployment` VALUES ('66c5113a-4eed-11ed-8d77-ec2e98f6b919','fogorvosApplication','2022-10-18 16:01:46','process application',NULL);
/*!40000 ALTER TABLE `act_re_deployment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_re_procdef`
--

DROP TABLE IF EXISTS `act_re_procdef`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `act_re_procdef` (
  `ID_` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `REV_` int DEFAULT NULL,
  `CATEGORY_` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `KEY_` varchar(255) COLLATE utf8mb3_bin NOT NULL,
  `VERSION_` int NOT NULL,
  `DEPLOYMENT_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `RESOURCE_NAME_` varchar(4000) COLLATE utf8mb3_bin DEFAULT NULL,
  `DGRM_RESOURCE_NAME_` varchar(4000) COLLATE utf8mb3_bin DEFAULT NULL,
  `HAS_START_FORM_KEY_` tinyint DEFAULT NULL,
  `SUSPENSION_STATE_` int DEFAULT NULL,
  `TENANT_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `VERSION_TAG_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `HISTORY_TTL_` int DEFAULT NULL,
  `STARTABLE_` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_PROCDEF_DEPLOYMENT_ID` (`DEPLOYMENT_ID_`),
  KEY `ACT_IDX_PROCDEF_TENANT_ID` (`TENANT_ID_`),
  KEY `ACT_IDX_PROCDEF_VER_TAG` (`VERSION_TAG_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_re_procdef`
--

LOCK TABLES `act_re_procdef` WRITE;
/*!40000 ALTER TABLE `act_re_procdef` DISABLE KEYS */;
INSERT INTO `act_re_procdef` VALUES ('Process_Fogorvos:2:66d6283c-4eed-11ed-8d77-ec2e98f6b919',1,'http://bpmn.io/schema/bpmn','Fogszabalyzo vizsgalat','Process_Fogorvos',2,'66c5113a-4eed-11ed-8d77-ec2e98f6b919','Process_Fogorvos.bpmn',NULL,0,1,NULL,NULL,NULL,1);
/*!40000 ALTER TABLE `act_re_procdef` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_ru_authorization`
--

DROP TABLE IF EXISTS `act_ru_authorization`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `act_ru_authorization` (
  `ID_` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `REV_` int NOT NULL,
  `TYPE_` int NOT NULL,
  `GROUP_ID_` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `USER_ID_` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `RESOURCE_TYPE_` int NOT NULL,
  `RESOURCE_ID_` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `PERMS_` int DEFAULT NULL,
  `REMOVAL_TIME_` datetime DEFAULT NULL,
  `ROOT_PROC_INST_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  UNIQUE KEY `ACT_UNIQ_AUTH_USER` (`USER_ID_`,`TYPE_`,`RESOURCE_TYPE_`,`RESOURCE_ID_`),
  UNIQUE KEY `ACT_UNIQ_AUTH_GROUP` (`GROUP_ID_`,`TYPE_`,`RESOURCE_TYPE_`,`RESOURCE_ID_`),
  KEY `ACT_IDX_AUTH_GROUP_ID` (`GROUP_ID_`),
  KEY `ACT_IDX_AUTH_RESOURCE_ID` (`RESOURCE_ID_`),
  KEY `ACT_IDX_AUTH_ROOT_PI` (`ROOT_PROC_INST_ID_`),
  KEY `ACT_IDX_AUTH_RM_TIME` (`REMOVAL_TIME_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_ru_authorization`
--

LOCK TABLES `act_ru_authorization` WRITE;
/*!40000 ALTER TABLE `act_ru_authorization` DISABLE KEYS */;
INSERT INTO `act_ru_authorization` VALUES ('888f7fc2-4eeb-11ed-a18b-ec2e98f6b919',1,1,'camunda-admin',NULL,0,'*',2147483647,NULL,NULL),('88904313-4eeb-11ed-a18b-ec2e98f6b919',1,1,'camunda-admin',NULL,1,'*',2147483647,NULL,NULL),('88910664-4eeb-11ed-a18b-ec2e98f6b919',1,1,'camunda-admin',NULL,2,'*',2147483647,NULL,NULL),('88923ee5-4eeb-11ed-a18b-ec2e98f6b919',1,1,'camunda-admin',NULL,3,'*',2147483647,NULL,NULL),('8892db26-4eeb-11ed-a18b-ec2e98f6b919',1,1,'camunda-admin',NULL,4,'*',2147483647,NULL,NULL),('8893c587-4eeb-11ed-a18b-ec2e98f6b919',1,1,'camunda-admin',NULL,5,'*',2147483647,NULL,NULL),('889488d8-4eeb-11ed-a18b-ec2e98f6b919',1,1,'camunda-admin',NULL,6,'*',2147483647,NULL,NULL),('88952519-4eeb-11ed-a18b-ec2e98f6b919',1,1,'camunda-admin',NULL,7,'*',2147483647,NULL,NULL),('8895e86a-4eeb-11ed-a18b-ec2e98f6b919',1,1,'camunda-admin',NULL,8,'*',2147483647,NULL,NULL),('8896f9db-4eeb-11ed-a18b-ec2e98f6b919',1,1,'camunda-admin',NULL,9,'*',2147483647,NULL,NULL),('8897bd2c-4eeb-11ed-a18b-ec2e98f6b919',1,1,'camunda-admin',NULL,10,'*',2147483647,NULL,NULL),('8898807d-4eeb-11ed-a18b-ec2e98f6b919',1,1,'camunda-admin',NULL,11,'*',2147483647,NULL,NULL),('889991ee-4eeb-11ed-a18b-ec2e98f6b919',1,1,'camunda-admin',NULL,12,'*',2147483647,NULL,NULL),('889a553f-4eeb-11ed-a18b-ec2e98f6b919',1,1,'camunda-admin',NULL,13,'*',2147483647,NULL,NULL),('889c5110-4eeb-11ed-a18b-ec2e98f6b919',1,1,'camunda-admin',NULL,14,'*',2147483647,NULL,NULL),('889d6281-4eeb-11ed-a18b-ec2e98f6b919',1,1,'camunda-admin',NULL,15,'*',2147483647,NULL,NULL),('889e25d2-4eeb-11ed-a18b-ec2e98f6b919',1,1,'camunda-admin',NULL,16,'*',2147483647,NULL,NULL),('889ee923-4eeb-11ed-a18b-ec2e98f6b919',1,1,'camunda-admin',NULL,17,'*',2147483647,NULL,NULL),('889fac74-4eeb-11ed-a18b-ec2e98f6b919',1,1,'camunda-admin',NULL,18,'*',2147483647,NULL,NULL),('88a06fc5-4eeb-11ed-a18b-ec2e98f6b919',1,1,'camunda-admin',NULL,19,'*',2147483647,NULL,NULL),('88a13316-4eeb-11ed-a18b-ec2e98f6b919',1,1,'camunda-admin',NULL,20,'*',2147483647,NULL,NULL),('88a1f667-4eeb-11ed-a18b-ec2e98f6b919',1,1,'camunda-admin',NULL,21,'*',2147483647,NULL,NULL);
/*!40000 ALTER TABLE `act_ru_authorization` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_ru_batch`
--

DROP TABLE IF EXISTS `act_ru_batch`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `act_ru_batch` (
  `ID_` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `REV_` int NOT NULL,
  `TYPE_` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `TOTAL_JOBS_` int DEFAULT NULL,
  `JOBS_CREATED_` int DEFAULT NULL,
  `JOBS_PER_SEED_` int DEFAULT NULL,
  `INVOCATIONS_PER_JOB_` int DEFAULT NULL,
  `SEED_JOB_DEF_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `BATCH_JOB_DEF_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `MONITOR_JOB_DEF_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `SUSPENSION_STATE_` int DEFAULT NULL,
  `CONFIGURATION_` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `TENANT_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `CREATE_USER_ID_` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `START_TIME_` datetime DEFAULT NULL,
  `EXEC_START_TIME_` datetime DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_BATCH_SEED_JOB_DEF` (`SEED_JOB_DEF_ID_`),
  KEY `ACT_IDX_BATCH_MONITOR_JOB_DEF` (`MONITOR_JOB_DEF_ID_`),
  KEY `ACT_IDX_BATCH_JOB_DEF` (`BATCH_JOB_DEF_ID_`),
  CONSTRAINT `ACT_FK_BATCH_JOB_DEF` FOREIGN KEY (`BATCH_JOB_DEF_ID_`) REFERENCES `act_ru_jobdef` (`ID_`),
  CONSTRAINT `ACT_FK_BATCH_MONITOR_JOB_DEF` FOREIGN KEY (`MONITOR_JOB_DEF_ID_`) REFERENCES `act_ru_jobdef` (`ID_`),
  CONSTRAINT `ACT_FK_BATCH_SEED_JOB_DEF` FOREIGN KEY (`SEED_JOB_DEF_ID_`) REFERENCES `act_ru_jobdef` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_ru_batch`
--

LOCK TABLES `act_ru_batch` WRITE;
/*!40000 ALTER TABLE `act_ru_batch` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_ru_batch` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_ru_case_execution`
--

DROP TABLE IF EXISTS `act_ru_case_execution`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `act_ru_case_execution` (
  `ID_` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `REV_` int DEFAULT NULL,
  `CASE_INST_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `SUPER_CASE_EXEC_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `SUPER_EXEC_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `BUSINESS_KEY_` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `PARENT_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `CASE_DEF_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `ACT_ID_` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `PREV_STATE_` int DEFAULT NULL,
  `CURRENT_STATE_` int DEFAULT NULL,
  `REQUIRED_` tinyint(1) DEFAULT NULL,
  `TENANT_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_CASE_EXEC_BUSKEY` (`BUSINESS_KEY_`),
  KEY `ACT_IDX_CASE_EXE_CASE_INST` (`CASE_INST_ID_`),
  KEY `ACT_FK_CASE_EXE_PARENT` (`PARENT_ID_`),
  KEY `ACT_FK_CASE_EXE_CASE_DEF` (`CASE_DEF_ID_`),
  KEY `ACT_IDX_CASE_EXEC_TENANT_ID` (`TENANT_ID_`),
  CONSTRAINT `ACT_FK_CASE_EXE_CASE_DEF` FOREIGN KEY (`CASE_DEF_ID_`) REFERENCES `act_re_case_def` (`ID_`),
  CONSTRAINT `ACT_FK_CASE_EXE_CASE_INST` FOREIGN KEY (`CASE_INST_ID_`) REFERENCES `act_ru_case_execution` (`ID_`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ACT_FK_CASE_EXE_PARENT` FOREIGN KEY (`PARENT_ID_`) REFERENCES `act_ru_case_execution` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_ru_case_execution`
--

LOCK TABLES `act_ru_case_execution` WRITE;
/*!40000 ALTER TABLE `act_ru_case_execution` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_ru_case_execution` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_ru_case_sentry_part`
--

DROP TABLE IF EXISTS `act_ru_case_sentry_part`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `act_ru_case_sentry_part` (
  `ID_` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `REV_` int DEFAULT NULL,
  `CASE_INST_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `CASE_EXEC_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `SENTRY_ID_` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `SOURCE_CASE_EXEC_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `STANDARD_EVENT_` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `SOURCE_` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `VARIABLE_EVENT_` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `VARIABLE_NAME_` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `SATISFIED_` tinyint(1) DEFAULT NULL,
  `TENANT_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_FK_CASE_SENTRY_CASE_INST` (`CASE_INST_ID_`),
  KEY `ACT_FK_CASE_SENTRY_CASE_EXEC` (`CASE_EXEC_ID_`),
  CONSTRAINT `ACT_FK_CASE_SENTRY_CASE_EXEC` FOREIGN KEY (`CASE_EXEC_ID_`) REFERENCES `act_ru_case_execution` (`ID_`),
  CONSTRAINT `ACT_FK_CASE_SENTRY_CASE_INST` FOREIGN KEY (`CASE_INST_ID_`) REFERENCES `act_ru_case_execution` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_ru_case_sentry_part`
--

LOCK TABLES `act_ru_case_sentry_part` WRITE;
/*!40000 ALTER TABLE `act_ru_case_sentry_part` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_ru_case_sentry_part` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_ru_event_subscr`
--

DROP TABLE IF EXISTS `act_ru_event_subscr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `act_ru_event_subscr` (
  `ID_` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `REV_` int DEFAULT NULL,
  `EVENT_TYPE_` varchar(255) COLLATE utf8mb3_bin NOT NULL,
  `EVENT_NAME_` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `ACTIVITY_ID_` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `CONFIGURATION_` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `CREATED_` datetime NOT NULL,
  `TENANT_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_EVENT_SUBSCR_CONFIG_` (`CONFIGURATION_`),
  KEY `ACT_IDX_EVENT_SUBSCR_TENANT_ID` (`TENANT_ID_`),
  KEY `ACT_FK_EVENT_EXEC` (`EXECUTION_ID_`),
  KEY `ACT_IDX_EVENT_SUBSCR_EVT_NAME` (`EVENT_NAME_`),
  CONSTRAINT `ACT_FK_EVENT_EXEC` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `act_ru_execution` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_ru_event_subscr`
--

LOCK TABLES `act_ru_event_subscr` WRITE;
/*!40000 ALTER TABLE `act_ru_event_subscr` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_ru_event_subscr` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_ru_execution`
--

DROP TABLE IF EXISTS `act_ru_execution`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `act_ru_execution` (
  `ID_` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `REV_` int DEFAULT NULL,
  `ROOT_PROC_INST_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `BUSINESS_KEY_` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `PARENT_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `SUPER_EXEC_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `SUPER_CASE_EXEC_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `CASE_INST_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `ACT_ID_` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `ACT_INST_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `IS_ACTIVE_` tinyint DEFAULT NULL,
  `IS_CONCURRENT_` tinyint DEFAULT NULL,
  `IS_SCOPE_` tinyint DEFAULT NULL,
  `IS_EVENT_SCOPE_` tinyint DEFAULT NULL,
  `SUSPENSION_STATE_` int DEFAULT NULL,
  `CACHED_ENT_STATE_` int DEFAULT NULL,
  `SEQUENCE_COUNTER_` bigint DEFAULT NULL,
  `TENANT_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_EXEC_ROOT_PI` (`ROOT_PROC_INST_ID_`),
  KEY `ACT_IDX_EXEC_BUSKEY` (`BUSINESS_KEY_`),
  KEY `ACT_IDX_EXEC_TENANT_ID` (`TENANT_ID_`),
  KEY `ACT_FK_EXE_PROCINST` (`PROC_INST_ID_`),
  KEY `ACT_FK_EXE_PARENT` (`PARENT_ID_`),
  KEY `ACT_FK_EXE_SUPER` (`SUPER_EXEC_`),
  KEY `ACT_FK_EXE_PROCDEF` (`PROC_DEF_ID_`),
  CONSTRAINT `ACT_FK_EXE_PARENT` FOREIGN KEY (`PARENT_ID_`) REFERENCES `act_ru_execution` (`ID_`),
  CONSTRAINT `ACT_FK_EXE_PROCDEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `act_re_procdef` (`ID_`),
  CONSTRAINT `ACT_FK_EXE_PROCINST` FOREIGN KEY (`PROC_INST_ID_`) REFERENCES `act_ru_execution` (`ID_`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ACT_FK_EXE_SUPER` FOREIGN KEY (`SUPER_EXEC_`) REFERENCES `act_ru_execution` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_ru_execution`
--

LOCK TABLES `act_ru_execution` WRITE;
/*!40000 ALTER TABLE `act_ru_execution` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_ru_execution` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_ru_ext_task`
--

DROP TABLE IF EXISTS `act_ru_ext_task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `act_ru_ext_task` (
  `ID_` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `REV_` int NOT NULL,
  `WORKER_ID_` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `TOPIC_NAME_` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `RETRIES_` int DEFAULT NULL,
  `ERROR_MSG_` varchar(4000) COLLATE utf8mb3_bin DEFAULT NULL,
  `ERROR_DETAILS_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `LOCK_EXP_TIME_` datetime DEFAULT NULL,
  `SUSPENSION_STATE_` int DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `PROC_DEF_KEY_` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `ACT_ID_` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `ACT_INST_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `TENANT_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `PRIORITY_` bigint NOT NULL DEFAULT '0',
  `LAST_FAILURE_LOG_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_EXT_TASK_TOPIC` (`TOPIC_NAME_`),
  KEY `ACT_IDX_EXT_TASK_TENANT_ID` (`TENANT_ID_`),
  KEY `ACT_IDX_EXT_TASK_PRIORITY` (`PRIORITY_`),
  KEY `ACT_IDX_EXT_TASK_ERR_DETAILS` (`ERROR_DETAILS_ID_`),
  KEY `ACT_IDX_EXT_TASK_EXEC` (`EXECUTION_ID_`),
  CONSTRAINT `ACT_FK_EXT_TASK_ERROR_DETAILS` FOREIGN KEY (`ERROR_DETAILS_ID_`) REFERENCES `act_ge_bytearray` (`ID_`),
  CONSTRAINT `ACT_FK_EXT_TASK_EXE` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `act_ru_execution` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_ru_ext_task`
--

LOCK TABLES `act_ru_ext_task` WRITE;
/*!40000 ALTER TABLE `act_ru_ext_task` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_ru_ext_task` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_ru_filter`
--

DROP TABLE IF EXISTS `act_ru_filter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `act_ru_filter` (
  `ID_` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `REV_` int NOT NULL,
  `RESOURCE_TYPE_` varchar(255) COLLATE utf8mb3_bin NOT NULL,
  `NAME_` varchar(255) COLLATE utf8mb3_bin NOT NULL,
  `OWNER_` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `QUERY_` longtext COLLATE utf8mb3_bin NOT NULL,
  `PROPERTIES_` longtext COLLATE utf8mb3_bin,
  PRIMARY KEY (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_ru_filter`
--

LOCK TABLES `act_ru_filter` WRITE;
/*!40000 ALTER TABLE `act_ru_filter` DISABLE KEYS */;
INSERT INTO `act_ru_filter` VALUES ('88a74d99-4eeb-11ed-a18b-ec2e98f6b919',1,'Task','All tasks',NULL,'{}','{}');
/*!40000 ALTER TABLE `act_ru_filter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_ru_identitylink`
--

DROP TABLE IF EXISTS `act_ru_identitylink`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `act_ru_identitylink` (
  `ID_` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `REV_` int DEFAULT NULL,
  `GROUP_ID_` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `USER_ID_` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `TENANT_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_IDENT_LNK_USER` (`USER_ID_`),
  KEY `ACT_IDX_IDENT_LNK_GROUP` (`GROUP_ID_`),
  KEY `ACT_IDX_ATHRZ_PROCEDEF` (`PROC_DEF_ID_`),
  KEY `ACT_FK_TSKASS_TASK` (`TASK_ID_`),
  CONSTRAINT `ACT_FK_ATHRZ_PROCEDEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `act_re_procdef` (`ID_`),
  CONSTRAINT `ACT_FK_TSKASS_TASK` FOREIGN KEY (`TASK_ID_`) REFERENCES `act_ru_task` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_ru_identitylink`
--

LOCK TABLES `act_ru_identitylink` WRITE;
/*!40000 ALTER TABLE `act_ru_identitylink` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_ru_identitylink` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_ru_incident`
--

DROP TABLE IF EXISTS `act_ru_incident`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `act_ru_incident` (
  `ID_` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `REV_` int NOT NULL,
  `INCIDENT_TIMESTAMP_` datetime NOT NULL,
  `INCIDENT_MSG_` varchar(4000) COLLATE utf8mb3_bin DEFAULT NULL,
  `INCIDENT_TYPE_` varchar(255) COLLATE utf8mb3_bin NOT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `ACTIVITY_ID_` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `FAILED_ACTIVITY_ID_` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `CAUSE_INCIDENT_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `ROOT_CAUSE_INCIDENT_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `CONFIGURATION_` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `TENANT_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `JOB_DEF_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `ANNOTATION_` varchar(4000) COLLATE utf8mb3_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_INC_CONFIGURATION` (`CONFIGURATION_`),
  KEY `ACT_IDX_INC_TENANT_ID` (`TENANT_ID_`),
  KEY `ACT_IDX_INC_JOB_DEF` (`JOB_DEF_ID_`),
  KEY `ACT_IDX_INC_CAUSEINCID` (`CAUSE_INCIDENT_ID_`),
  KEY `ACT_IDX_INC_EXID` (`EXECUTION_ID_`),
  KEY `ACT_IDX_INC_PROCDEFID` (`PROC_DEF_ID_`),
  KEY `ACT_IDX_INC_PROCINSTID` (`PROC_INST_ID_`),
  KEY `ACT_IDX_INC_ROOTCAUSEINCID` (`ROOT_CAUSE_INCIDENT_ID_`),
  CONSTRAINT `ACT_FK_INC_CAUSE` FOREIGN KEY (`CAUSE_INCIDENT_ID_`) REFERENCES `act_ru_incident` (`ID_`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `ACT_FK_INC_EXE` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `act_ru_execution` (`ID_`),
  CONSTRAINT `ACT_FK_INC_JOB_DEF` FOREIGN KEY (`JOB_DEF_ID_`) REFERENCES `act_ru_jobdef` (`ID_`),
  CONSTRAINT `ACT_FK_INC_PROCDEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `act_re_procdef` (`ID_`),
  CONSTRAINT `ACT_FK_INC_PROCINST` FOREIGN KEY (`PROC_INST_ID_`) REFERENCES `act_ru_execution` (`ID_`),
  CONSTRAINT `ACT_FK_INC_RCAUSE` FOREIGN KEY (`ROOT_CAUSE_INCIDENT_ID_`) REFERENCES `act_ru_incident` (`ID_`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_ru_incident`
--

LOCK TABLES `act_ru_incident` WRITE;
/*!40000 ALTER TABLE `act_ru_incident` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_ru_incident` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_ru_job`
--

DROP TABLE IF EXISTS `act_ru_job`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `act_ru_job` (
  `ID_` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `REV_` int DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8mb3_bin NOT NULL,
  `LOCK_EXP_TIME_` datetime DEFAULT NULL,
  `LOCK_OWNER_` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `EXCLUSIVE_` tinyint(1) DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `PROCESS_INSTANCE_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `PROCESS_DEF_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `PROCESS_DEF_KEY_` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `RETRIES_` int DEFAULT NULL,
  `EXCEPTION_STACK_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `EXCEPTION_MSG_` varchar(4000) COLLATE utf8mb3_bin DEFAULT NULL,
  `FAILED_ACT_ID_` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `DUEDATE_` datetime DEFAULT NULL,
  `REPEAT_` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `REPEAT_OFFSET_` bigint DEFAULT '0',
  `HANDLER_TYPE_` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `HANDLER_CFG_` varchar(4000) COLLATE utf8mb3_bin DEFAULT NULL,
  `DEPLOYMENT_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `SUSPENSION_STATE_` int NOT NULL DEFAULT '1',
  `JOB_DEF_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `PRIORITY_` bigint NOT NULL DEFAULT '0',
  `SEQUENCE_COUNTER_` bigint DEFAULT NULL,
  `TENANT_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `CREATE_TIME_` datetime DEFAULT NULL,
  `LAST_FAILURE_LOG_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_JOB_EXECUTION_ID` (`EXECUTION_ID_`),
  KEY `ACT_IDX_JOB_HANDLER` (`HANDLER_TYPE_`(100),`HANDLER_CFG_`(155)),
  KEY `ACT_IDX_JOB_PROCINST` (`PROCESS_INSTANCE_ID_`),
  KEY `ACT_IDX_JOB_TENANT_ID` (`TENANT_ID_`),
  KEY `ACT_IDX_JOB_JOB_DEF_ID` (`JOB_DEF_ID_`),
  KEY `ACT_FK_JOB_EXCEPTION` (`EXCEPTION_STACK_ID_`),
  KEY `ACT_IDX_JOB_HANDLER_TYPE` (`HANDLER_TYPE_`),
  CONSTRAINT `ACT_FK_JOB_EXCEPTION` FOREIGN KEY (`EXCEPTION_STACK_ID_`) REFERENCES `act_ge_bytearray` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_ru_job`
--

LOCK TABLES `act_ru_job` WRITE;
/*!40000 ALTER TABLE `act_ru_job` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_ru_job` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_ru_jobdef`
--

DROP TABLE IF EXISTS `act_ru_jobdef`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `act_ru_jobdef` (
  `ID_` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `REV_` int DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `PROC_DEF_KEY_` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `ACT_ID_` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `JOB_TYPE_` varchar(255) COLLATE utf8mb3_bin NOT NULL,
  `JOB_CONFIGURATION_` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `SUSPENSION_STATE_` int DEFAULT NULL,
  `JOB_PRIORITY_` bigint DEFAULT NULL,
  `TENANT_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `DEPLOYMENT_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_JOBDEF_TENANT_ID` (`TENANT_ID_`),
  KEY `ACT_IDX_JOBDEF_PROC_DEF_ID` (`PROC_DEF_ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_ru_jobdef`
--

LOCK TABLES `act_ru_jobdef` WRITE;
/*!40000 ALTER TABLE `act_ru_jobdef` DISABLE KEYS */;
INSERT INTO `act_ru_jobdef` VALUES ('66d64f4d-4eed-11ed-8d77-ec2e98f6b919',1,'Process_Fogorvos:2:66d6283c-4eed-11ed-8d77-ec2e98f6b919','Process_Fogorvos','Event_12fcodo','timer-transition','CYCLE: R1/PT15S',1,NULL,NULL,NULL);
/*!40000 ALTER TABLE `act_ru_jobdef` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_ru_meter_log`
--

DROP TABLE IF EXISTS `act_ru_meter_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `act_ru_meter_log` (
  `ID_` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `NAME_` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `REPORTER_` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `VALUE_` bigint DEFAULT NULL,
  `TIMESTAMP_` datetime DEFAULT NULL,
  `MILLISECONDS_` bigint DEFAULT '0',
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_METER_LOG_MS` (`MILLISECONDS_`),
  KEY `ACT_IDX_METER_LOG_NAME_MS` (`NAME_`,`MILLISECONDS_`),
  KEY `ACT_IDX_METER_LOG_REPORT` (`NAME_`,`REPORTER_`,`MILLISECONDS_`),
  KEY `ACT_IDX_METER_LOG_TIME` (`TIMESTAMP_`),
  KEY `ACT_IDX_METER_LOG` (`NAME_`,`TIMESTAMP_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_ru_meter_log`
--

LOCK TABLES `act_ru_meter_log` WRITE;
/*!40000 ALTER TABLE `act_ru_meter_log` DISABLE KEYS */;
INSERT INTO `act_ru_meter_log` VALUES ('61276207-4eed-11ed-a18b-ec2e98f6b919','root-process-instance-start','192.168.99.56$default',1,'2022-10-18 16:01:36',1666101696253),('61276208-4eed-11ed-a18b-ec2e98f6b919','activity-instance-start','192.168.99.56$default',6,'2022-10-18 16:01:36',1666101696253),('61276209-4eed-11ed-a18b-ec2e98f6b919','job-acquired-failure','192.168.99.56$default',0,'2022-10-18 16:01:36',1666101696253),('6127620a-4eed-11ed-a18b-ec2e98f6b919','job-locked-exclusive','192.168.99.56$default',0,'2022-10-18 16:01:36',1666101696253),('6127620b-4eed-11ed-a18b-ec2e98f6b919','job-execution-rejected','192.168.99.56$default',0,'2022-10-18 16:01:36',1666101696253),('6127620c-4eed-11ed-a18b-ec2e98f6b919','executed-decision-elements','192.168.99.56$default',0,'2022-10-18 16:01:36',1666101696253),('6127620d-4eed-11ed-a18b-ec2e98f6b919','activity-instance-end','192.168.99.56$default',6,'2022-10-18 16:01:36',1666101696253),('6127620e-4eed-11ed-a18b-ec2e98f6b919','job-successful','192.168.99.56$default',0,'2022-10-18 16:01:36',1666101696253),('6127620f-4eed-11ed-a18b-ec2e98f6b919','job-acquired-success','192.168.99.56$default',0,'2022-10-18 16:01:36',1666101696253),('61276210-4eed-11ed-a18b-ec2e98f6b919','job-acquisition-attempt','192.168.99.56$default',16,'2022-10-18 16:01:36',1666101696253),('61276211-4eed-11ed-a18b-ec2e98f6b919','executed-decision-instances','192.168.99.56$default',0,'2022-10-18 16:01:36',1666101696253),('61276212-4eed-11ed-a18b-ec2e98f6b919','job-failed','192.168.99.56$default',0,'2022-10-18 16:01:36',1666101696253),('7ed320f1-4eeb-11ed-a0a7-ec2e98f6b919','root-process-instance-start','192.168.99.56$default',0,'2022-10-18 15:48:07',1666100887039),('7ed320f2-4eeb-11ed-a0a7-ec2e98f6b919','activity-instance-start','192.168.99.56$default',0,'2022-10-18 15:48:07',1666100887039),('7ed320f3-4eeb-11ed-a0a7-ec2e98f6b919','job-acquired-failure','192.168.99.56$default',0,'2022-10-18 15:48:07',1666100887039),('7ed320f4-4eeb-11ed-a0a7-ec2e98f6b919','job-locked-exclusive','192.168.99.56$default',0,'2022-10-18 15:48:07',1666100887039),('7ed320f5-4eeb-11ed-a0a7-ec2e98f6b919','job-execution-rejected','192.168.99.56$default',0,'2022-10-18 15:48:07',1666100887039),('7ed320f6-4eeb-11ed-a0a7-ec2e98f6b919','executed-decision-elements','192.168.99.56$default',0,'2022-10-18 15:48:07',1666100887039),('7ed320f7-4eeb-11ed-a0a7-ec2e98f6b919','activity-instance-end','192.168.99.56$default',0,'2022-10-18 15:48:07',1666100887039),('7ed320f8-4eeb-11ed-a0a7-ec2e98f6b919','job-successful','192.168.99.56$default',0,'2022-10-18 15:48:07',1666100887039),('7ed320f9-4eeb-11ed-a0a7-ec2e98f6b919','job-acquired-success','192.168.99.56$default',0,'2022-10-18 15:48:07',1666100887039),('7ed320fa-4eeb-11ed-a0a7-ec2e98f6b919','job-acquisition-attempt','192.168.99.56$default',2,'2022-10-18 15:48:07',1666100887039),('7ed320fb-4eeb-11ed-a0a7-ec2e98f6b919','executed-decision-instances','192.168.99.56$default',0,'2022-10-18 15:48:07',1666100887039),('7ed320fc-4eeb-11ed-a0a7-ec2e98f6b919','job-failed','192.168.99.56$default',0,'2022-10-18 15:48:07',1666100887039);
/*!40000 ALTER TABLE `act_ru_meter_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_ru_task`
--

DROP TABLE IF EXISTS `act_ru_task`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `act_ru_task` (
  `ID_` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `REV_` int DEFAULT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `CASE_EXECUTION_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `CASE_INST_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `CASE_DEF_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `NAME_` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `PARENT_TASK_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `DESCRIPTION_` varchar(4000) COLLATE utf8mb3_bin DEFAULT NULL,
  `TASK_DEF_KEY_` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `OWNER_` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `ASSIGNEE_` varchar(255) COLLATE utf8mb3_bin DEFAULT NULL,
  `DELEGATION_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `PRIORITY_` int DEFAULT NULL,
  `CREATE_TIME_` datetime DEFAULT NULL,
  `LAST_UPDATED_` datetime DEFAULT NULL,
  `DUE_DATE_` datetime DEFAULT NULL,
  `FOLLOW_UP_DATE_` datetime DEFAULT NULL,
  `SUSPENSION_STATE_` int DEFAULT NULL,
  `TENANT_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_TASK_CREATE` (`CREATE_TIME_`),
  KEY `ACT_IDX_TASK_LAST_UPDATED` (`LAST_UPDATED_`),
  KEY `ACT_IDX_TASK_ASSIGNEE` (`ASSIGNEE_`),
  KEY `ACT_IDX_TASK_OWNER` (`OWNER_`),
  KEY `ACT_IDX_TASK_TENANT_ID` (`TENANT_ID_`),
  KEY `ACT_FK_TASK_EXE` (`EXECUTION_ID_`),
  KEY `ACT_FK_TASK_PROCINST` (`PROC_INST_ID_`),
  KEY `ACT_FK_TASK_PROCDEF` (`PROC_DEF_ID_`),
  KEY `ACT_FK_TASK_CASE_EXE` (`CASE_EXECUTION_ID_`),
  KEY `ACT_FK_TASK_CASE_DEF` (`CASE_DEF_ID_`),
  CONSTRAINT `ACT_FK_TASK_CASE_DEF` FOREIGN KEY (`CASE_DEF_ID_`) REFERENCES `act_re_case_def` (`ID_`),
  CONSTRAINT `ACT_FK_TASK_CASE_EXE` FOREIGN KEY (`CASE_EXECUTION_ID_`) REFERENCES `act_ru_case_execution` (`ID_`),
  CONSTRAINT `ACT_FK_TASK_EXE` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `act_ru_execution` (`ID_`),
  CONSTRAINT `ACT_FK_TASK_PROCDEF` FOREIGN KEY (`PROC_DEF_ID_`) REFERENCES `act_re_procdef` (`ID_`),
  CONSTRAINT `ACT_FK_TASK_PROCINST` FOREIGN KEY (`PROC_INST_ID_`) REFERENCES `act_ru_execution` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_ru_task`
--

LOCK TABLES `act_ru_task` WRITE;
/*!40000 ALTER TABLE `act_ru_task` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_ru_task` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_ru_task_meter_log`
--

DROP TABLE IF EXISTS `act_ru_task_meter_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `act_ru_task_meter_log` (
  `ID_` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `ASSIGNEE_HASH_` bigint DEFAULT NULL,
  `TIMESTAMP_` datetime DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  KEY `ACT_IDX_TASK_METER_LOG_TIME` (`TIMESTAMP_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_ru_task_meter_log`
--

LOCK TABLES `act_ru_task_meter_log` WRITE;
/*!40000 ALTER TABLE `act_ru_task_meter_log` DISABLE KEYS */;
INSERT INTO `act_ru_task_meter_log` VALUES ('6f99f668-4eed-11ed-8d77-ec2e98f6b919',-7840326142560265509,'2022-10-18 16:02:00'),('7bc61ccd-4eed-11ed-8d77-ec2e98f6b919',-7840326142560265509,'2022-10-18 16:02:21'),('7f06a1d8-4eed-11ed-8d77-ec2e98f6b919',-7840326142560265509,'2022-10-18 16:02:26'),('8e04d3ff-4eed-11ed-8d77-ec2e98f6b919',-7840326142560265509,'2022-10-18 16:02:52'),('8f30f7f6-4eed-11ed-8d77-ec2e98f6b919',-7840326142560265509,'2022-10-18 16:02:53'),('9017d58c-4eed-11ed-8d77-ec2e98f6b919',-7840326142560265509,'2022-10-18 16:02:55'),('91196713-4eed-11ed-8d77-ec2e98f6b919',-7840326142560265509,'2022-10-18 16:02:57'),('93d64e6a-4eeb-11ed-a18b-ec2e98f6b919',-7840326142560265509,'2022-10-18 15:48:42'),('9a898c01-4eeb-11ed-a18b-ec2e98f6b919',-7840326142560265509,'2022-10-18 15:48:54');
/*!40000 ALTER TABLE `act_ru_task_meter_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `act_ru_variable`
--

DROP TABLE IF EXISTS `act_ru_variable`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `act_ru_variable` (
  `ID_` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `REV_` int DEFAULT NULL,
  `TYPE_` varchar(255) COLLATE utf8mb3_bin NOT NULL,
  `NAME_` varchar(255) COLLATE utf8mb3_bin NOT NULL,
  `EXECUTION_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `PROC_INST_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `PROC_DEF_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `CASE_EXECUTION_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `CASE_INST_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `TASK_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `BATCH_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `BYTEARRAY_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  `DOUBLE_` double DEFAULT NULL,
  `LONG_` bigint DEFAULT NULL,
  `TEXT_` varchar(4000) COLLATE utf8mb3_bin DEFAULT NULL,
  `TEXT2_` varchar(4000) COLLATE utf8mb3_bin DEFAULT NULL,
  `VAR_SCOPE_` varchar(64) COLLATE utf8mb3_bin NOT NULL,
  `SEQUENCE_COUNTER_` bigint DEFAULT NULL,
  `IS_CONCURRENT_LOCAL_` tinyint DEFAULT NULL,
  `TENANT_ID_` varchar(64) COLLATE utf8mb3_bin DEFAULT NULL,
  PRIMARY KEY (`ID_`),
  UNIQUE KEY `ACT_UNIQ_VARIABLE` (`VAR_SCOPE_`,`NAME_`),
  KEY `ACT_IDX_VARIABLE_TASK_ID` (`TASK_ID_`),
  KEY `ACT_IDX_VARIABLE_TENANT_ID` (`TENANT_ID_`),
  KEY `ACT_IDX_VARIABLE_TASK_NAME_TYPE` (`TASK_ID_`,`NAME_`,`TYPE_`),
  KEY `ACT_FK_VAR_EXE` (`EXECUTION_ID_`),
  KEY `ACT_FK_VAR_PROCINST` (`PROC_INST_ID_`),
  KEY `ACT_FK_VAR_BYTEARRAY` (`BYTEARRAY_ID_`),
  KEY `ACT_IDX_BATCH_ID` (`BATCH_ID_`),
  KEY `ACT_FK_VAR_CASE_EXE` (`CASE_EXECUTION_ID_`),
  KEY `ACT_FK_VAR_CASE_INST` (`CASE_INST_ID_`),
  CONSTRAINT `ACT_FK_VAR_BATCH` FOREIGN KEY (`BATCH_ID_`) REFERENCES `act_ru_batch` (`ID_`),
  CONSTRAINT `ACT_FK_VAR_BYTEARRAY` FOREIGN KEY (`BYTEARRAY_ID_`) REFERENCES `act_ge_bytearray` (`ID_`),
  CONSTRAINT `ACT_FK_VAR_CASE_EXE` FOREIGN KEY (`CASE_EXECUTION_ID_`) REFERENCES `act_ru_case_execution` (`ID_`),
  CONSTRAINT `ACT_FK_VAR_CASE_INST` FOREIGN KEY (`CASE_INST_ID_`) REFERENCES `act_ru_case_execution` (`ID_`),
  CONSTRAINT `ACT_FK_VAR_EXE` FOREIGN KEY (`EXECUTION_ID_`) REFERENCES `act_ru_execution` (`ID_`),
  CONSTRAINT `ACT_FK_VAR_PROCINST` FOREIGN KEY (`PROC_INST_ID_`) REFERENCES `act_ru_execution` (`ID_`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `act_ru_variable`
--

LOCK TABLES `act_ru_variable` WRITE;
/*!40000 ALTER TABLE `act_ru_variable` DISABLE KEYS */;
/*!40000 ALTER TABLE `act_ru_variable` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-10-18 16:03:59
