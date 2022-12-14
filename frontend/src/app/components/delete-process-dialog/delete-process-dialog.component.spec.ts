import { ComponentFixture, TestBed } from '@angular/core/testing';

import { DeleteProcessDialogComponent } from './delete-process-dialog.component';

describe('DeleteProcessDialogComponent', () => {
  let component: DeleteProcessDialogComponent;
  let fixture: ComponentFixture<DeleteProcessDialogComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ DeleteProcessDialogComponent ]
    })
    .compileComponents();

    fixture = TestBed.createComponent(DeleteProcessDialogComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
