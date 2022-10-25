import { ComponentFixture, TestBed } from '@angular/core/testing';

import { SzakorvosiVizsgalatComponent } from './szakorvosi-vizsgalat.component';

describe('SzakorvosiVizsgalatComponent', () => {
  let component: SzakorvosiVizsgalatComponent;
  let fixture: ComponentFixture<SzakorvosiVizsgalatComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ SzakorvosiVizsgalatComponent ]
    })
    .compileComponents();

    fixture = TestBed.createComponent(SzakorvosiVizsgalatComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
