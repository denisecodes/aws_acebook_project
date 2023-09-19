const HomeController = {
  Index: function(req, res) {
    res.render('posts/index', { title: 'Acebook' });
  }
};

module.exports = HomeController;
