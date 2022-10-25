import { TaskPayload } from '../generic/task';

export class VizsgalatDto extends TaskPayload {
  rontgen: boolean;
}

export class BetegErtesiteseDto extends TaskPayload {
  elmarad: boolean;
}

export class FelulVizsgalatDto extends TaskPayload {
  szakorvosiVizsgalat: boolean;
}

export class SzakorvosiVizsgalatDto extends TaskPayload {
  fogszabalyzo: boolean;
}

export class FogszabalyzoFelrakasaDto extends TaskPayload {}

export class MegjelenesIdopontonDto extends TaskPayload {}

export class RontgenDto extends TaskPayload {}
