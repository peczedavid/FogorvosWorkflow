import { ComponentFixture, TestBed } from '@angular/core/testing';

import { RontgenComponent } from './rontgen.component';

describe('RontgenComponent', () => {
  let component: RontgenComponent;
  let fixture: ComponentFixture<RontgenComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ RontgenComponent ]
    })
    .compileComponents();

    fixture = TestBed.createComponent(RontgenComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
