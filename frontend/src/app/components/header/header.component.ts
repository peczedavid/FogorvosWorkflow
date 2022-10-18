import { Component, OnInit } from '@angular/core';
import { HttpClient } from '@angular/common/http';

@Component({
  selector: 'app-header',
  templateUrl: './header.component.html',
  styleUrls: ['./header.component.css'],
})
export class HeaderComponent implements OnInit {
  title: string = 'Fogorvos frontend';

  constructor(private http: HttpClient) {}

  ngOnInit(): void {}

  onDebugSend(): void {
    this.http
      .post<DebugResponse>('http://localhost:8080/debug/start', null)
      .subscribe((data) => {
        console.log(data.taskId);
      });
  }
}

interface DebugResponse {
  taskId: string;
}
