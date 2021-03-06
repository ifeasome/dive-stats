const db = require('../config/connection');

class Diver {
  //get-all GET route
  getAll() {
    return db.query(`SELECT * FROM divers ORDER BY last_name`);
  }

  //get-one GET route
  getOne({ id }) {
    return db.query(
      `SELECT * FROM divers WHERE id = $1`,
      [ id ]
    );
  }

  //get-total-dives GET route
  getTotalDives({ id }) {
    return db.query(
      `SELECT COUNT(diver_id) AS number_of_dives
      FROM dives
      WHERE diver_id = $1
      GROUP BY diver_id`,
      [ id ]
    );
  }

  //create POST route
  create({ first_name, last_name, is_instructor, certification_id }) {
    return db.query(
      `INSERT INTO divers (first_name, last_name, is_instructor, certification_id)
      VALUES ($1, $2, $3, $4) 
      RETURNING *`,
      [ first_name, last_name, is_instructor, certification_id ]
    );
  }
}

module.exports = new Diver();