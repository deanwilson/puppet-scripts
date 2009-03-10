CmdUtils.CreateCommand({
  name: "puppet-type",

  homepage: "http://www.unixdaemon.net/ubiquity_commands.html",
  author: { name: "Dean Wilson", email: "dean.wilson@gmail.com"},
  contributors: ["Dean Wilson"],
  license: "MPL",
  description: "puppet-type <typename> takes you to the documentation for the given puppet type",
  help: "puppet-type <typename> takes you to the documentation for the given puppet type",

  takes: {"puppet type": noun_arb_text},

  preview: "Navigate to the given puppet type",
  execute: function( puppettype ) {
    var baseurl = 'http://reductivelabs.com/trac/puppet/wiki/TypeReference#';

    Utils.openUrlInBrowser( baseurl + puppettype.text );
  }
})
