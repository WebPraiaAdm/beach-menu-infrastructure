// const restaurantMock = require("./mockedData.js");
import { restaurant as restaurantMock } from "./mockedData.js";

const URL = "http://localhost:8080";

const savedRestaurant = await fetch(`${URL}/admin/restaurants`, {
  method: "POST",
  body: JSON.stringify(restaurantMock),
  headers: {
    "Content-Type": "application/json",
  },
}).then((res) => res.json());



console.log(savedRestaurant);
