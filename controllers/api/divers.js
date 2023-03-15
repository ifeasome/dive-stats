const router = require('express').Router();
const { Router } = require('express');
const { Diver } = require('../../models');

//GET route for all Divers
router.get('/', async (req, res) => {
  const { rows } = await Diver.getAll();
  res.json(rows);
});

//GET route for one diver by ID 
router.get('/:id', async (req, res) => {
  const { rows } = await Diver.getOne({
    id: req.params.id
  });

  res.json(rows[0] || {});
});

//GET route for total dives
router.get('/:id/stats', async (req, res) => {
    if (req.query.data === 'total_dives') {
      const { rows } = await Diver.getTotalDives({
        id: req.params.id
      });
  
      res.json(rows[0] || {});
    }
    else {
      res.status(404).end();
    }
  });

  //POST route for diver Model
  router.post('/', async (req, res) => {
    try {
      const { rows } = await Diver.create(req.body);
      res.json(rows[0]);
    }
    catch (err) {
      res.status(500).json(err);
    }
  });

module.exports = router;
