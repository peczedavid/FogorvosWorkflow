import { ComponentFixture, TestBed } from '@angular/core/testing';

import { FelulvizsgalatComponent } from './felulvizsgalat.component';

describe('FelulvizsgalatComponent', () => {
  let component: FelulvizsgalatComponent;
  let fixture: ComponentFixture<FelulvizsgalatComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ FelulvizsgalatComponent ]
    })
    .compileComponents();

    fixture = TestBed.createComponent(FelulvizsgalatComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
