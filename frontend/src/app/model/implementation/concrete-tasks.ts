import { TaskPayload } from '../generic/task';

export interface VizsgalatDto extends TaskPayload {
  rontgen: boolean;
}

export interface BetegErtesiteseDto extends TaskPayload {
  elmarad: boolean;
}

export interface FelulVizsgalatDto extends TaskPayload {
  szakorvosiVizsgalat: boolean;
}

export interface SzakorvosiVizsgalatDto extends TaskPayload {
  fogszabalyzo: boolean;
}

export interface FogszabalyzoFelrakasaDto extends TaskPayload {}

export interface MegjelenesIdopontonDto extends TaskPayload {}

export interface RontgenDto extends TaskPayload {}
