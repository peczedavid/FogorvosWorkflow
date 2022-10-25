import { ComponentFixture, TestBed } from '@angular/core/testing';

import { BetegErtesiteseComponent } from './beteg-ertesitese.component';

describe('BetegErtesiteseComponent', () => {
  let component: BetegErtesiteseComponent;
  let fixture: ComponentFixture<BetegErtesiteseComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ BetegErtesiteseComponent ]
    })
    .compileComponents();

    fixture = TestBed.createComponent(BetegErtesiteseComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
