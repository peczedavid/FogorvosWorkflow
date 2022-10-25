import { ComponentFixture, TestBed } from '@angular/core/testing';

import { VariableCheckboxComponent } from './variable-checkbox.component';

describe('VariableCheckboxComponent', () => {
  let component: VariableCheckboxComponent;
  let fixture: ComponentFixture<VariableCheckboxComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ VariableCheckboxComponent ]
    })
    .compileComponents();

    fixture = TestBed.createComponent(VariableCheckboxComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
