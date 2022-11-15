import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'app-home',
  template: `
    <div class="welcome-page">
      <h1>Online klinika</h1>
      <p align="justify">
        Lorem ipsum dolor sit amet, consectetur adipisicing elit. Pariatur vero
        voluptatum dignissimos quod. Eveniet doloribus mollitia eius assumenda,
        illo sequi id officiis quos, numquam cupiditate iusto sed necessitatibus
        quod! Inventore, excepturi iusto nostrum voluptas impedit eum quae
        quibusdam! Earum, aut. Sunt odit libero totam beatae commodi autem hic
        enim assumenda modi quia molestiae omnis corrupti impedit, praesentium
        aut itaque neque eveniet non laudantium porro in amet. Distinctio,
        officiis temporibus unde ullam ratione consequatur, exercitationem
        perspiciatis atque tenetur ea asperiores nulla.
      </p>
      <p align="justify">
        Lorem ipsum dolor sit, amet consectetur adipisicing elit. Quis tempora,
        nisi qui dicta ab libero officiis temporibus animi alias adipisci
        commodi sapiente obcaecati soluta odit repellendus iure accusantium
        provident ut consectetur cumque totam. In quod odio officia esse illum
        nesciunt, illo doloribus aspernatur neque enim ut quam reiciendis
        quaerat ratione! Debitis, repellat minima, ipsa placeat maxime ea illum
        officia et quaerat molestias labore accusamus nulla earum dolor unde,
        sunt vitae molestiae dignissimos sequi voluptas facilis quam sit? Quo
        atque similique voluptatum neque, molestias maiores blanditiis
        asperiores maxime perspiciatis, expedita adipisci iusto reprehenderit
        reiciendis ducimus? Eligendi dolor earum blanditiis veritatis ut?
      </p>
    </div>
  `,
  styleUrls: ['./home.component.css'],
})
export class HomeComponent implements OnInit {
  constructor() {}

  ngOnInit(): void {}
}
