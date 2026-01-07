using { sap.capire.bookshop as my } from '../db/schema';

@requires: 'any'
service CatalogService @(path:'/browse') {

  /** For displaying lists of Books */
  @readonly entity ListOfBooks as projection on Books {
    *, currency.symbol as currency,
  } excluding { descr };

  /** For display in details pages */
  @readonly entity Books as projection on my.Books {
    *, // all fields with the following denormalizations:
    author.name as author, 
    genre.name as genre,
  } excluding { createdBy, modifiedBy, author };

  @requires: 'authenticated-user'
  action submitOrder ( book: Books:ID, quantity: Integer );

}

annotate CatalogService with @odata;
// Additionally serve via HCQL and REST
// missing in java: annotate CatalogService with @hcql @rest;
