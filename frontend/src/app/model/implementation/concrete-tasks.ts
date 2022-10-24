import '../generic/task';

interface VizsgalatDto extends TaskPayload {
  rontgen: boolean;
}

interface BetegErtesiteseDto extends TaskPayload {
  elmarad: boolean;
}

interface FelulVizsgalatDto extends TaskPayload {
  szakorvosiVizsgalat: boolean;
}

interface BetegErtesiteseDto extends TaskPayload {
  elmarad: boolean;
}

interface SzakorvosiVizsgalatDto extends TaskPayload {
  fogszabalyzo: boolean;
}

interface FogszabalyzoFelrakasaDto extends TaskPayload {}

interface MegjelenesIdopontonDto extends TaskPayload {}

interface RontgenDto extends TaskPayload {}
