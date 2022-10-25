import { ComponentFixture, TestBed } from '@angular/core/testing';

import { VizsgalatComponent } from './vizsgalat.component';

describe('VizsgalatComponent', () => {
  let component: VizsgalatComponent;
  let fixture: ComponentFixture<VizsgalatComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ VizsgalatComponent ]
    })
    .compileComponents();

    fixture = TestBed.createComponent(VizsgalatComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
