using { AdminService } from './admin-service.cds';

// Add constraints for input validation
annotate AdminService.Books with {

  title @mandatory;

  author @assert: (case 
    when not exists author then 'Specified Author does not exist'
  end);

  genre @mandatory @assert: (case 
    when not exists genre then 'Specified Genre does not exist'
  end);

  price @assert.range: [1,111]; // 1 ... 111 inclusive
  stock @assert.range: [(0),_]; // positive numbers only
}

// Require 'admin' role to access AdminService
// (disabled for getting-started guide)
// annotate AdminService with @requires:'admin';
