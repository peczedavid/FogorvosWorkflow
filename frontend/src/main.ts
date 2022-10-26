import { enableProdMode } from '@angular/core';
import { platformBrowserDynamic } from '@angular/platform-browser-dynamic';

import { AppModule } from './app/app.module';
import { environment } from './environments/environment';

if (environment.production) {
  enableProdMode();
}

platformBrowserDynamic().bootstrapModule(AppModule)
  .catch(err => console.error(err));

// TODO: state management -> váltózó állítására frissíteni a selected task-ot
//                           vagy lehet az összes task-ot és újra beállítani selected task-nak ugyanazt
