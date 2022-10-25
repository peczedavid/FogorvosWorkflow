import { ComponentFixture, TestBed } from '@angular/core/testing';

import { FogszabalyzoFelrakasaComponent } from './fogszabalyzo-felrakasa.component';

describe('FogszabalyzoFelrakasaComponent', () => {
  let component: FogszabalyzoFelrakasaComponent;
  let fixture: ComponentFixture<FogszabalyzoFelrakasaComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ FogszabalyzoFelrakasaComponent ]
    })
    .compileComponents();

    fixture = TestBed.createComponent(FogszabalyzoFelrakasaComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
