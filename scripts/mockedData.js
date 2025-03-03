const crypto = require("crypto");

const restaurant = {
  name: "Beach Menu Boostrapped Restaurant",
  contractId: null,
  tradeName: "Beach Menu BR",
  pixKey: crypto.randomUUID().toString(),
  address: {
    street: "Av. Marechal Hermes",
    neighborhood: "Canto do Forte",
    number: "1",
    cep: "11700250",
    state: "São Paulo",
    city: "Praia Grande",
    complement: "Casa 1",
  },
  documentType: "CPF",
  documentValue: "000.000.000-00",
  restaurantTables: [
    {
      tableNumber: "1",
      capacity: "8",
      paidOnRestaurant: true,
    },
  ],
};

function generateProducts(restaurantId) {
  return [
    {
      restaurantId,
      name: "Coca-Cola",
      description: "Lata 350ml",
      type: "NON_ALCOHOLIC",
    },
  ];
}

module.exports = { restaurant, generateProducts };
