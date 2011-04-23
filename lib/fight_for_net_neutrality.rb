# Encoding: utf-8

require "rack"
require "ipaddr"


class FightForNetNeutrality
  def initialize(app, ips=nil)
    ips ||= ["62.160.71.0/24", "84.233.174.48/28", "80.118.39.160/27"]
    @app = app
    @ips_banned = ips.map {|ip| IPAddr.new(ip) }
    @html = HTML % ips.map {|ip| "<li>#{ip}</li>" }.join
  end

  def call(env)
    req = Rack::Request.new(env)
    if @ips_banned.any? {|ips| ips.include? req.ip }
      [403, {"Content-Type" => "text/html; charset=utf8"}, [@html]]
    else
      @app.call(env)
    end
  end
end


HTML = <<-EOS
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>Ressource inaccessible</title>
<style>
h1{font-size:14px; padding-top:5px}
h2{font-size:12px}
</style>
</head>
<body>
<div style="width:800px; margin:0 auto;">
<img src="http://www.paulds.fr/p4ul/blocked/france.jpg" alt="liberté, égalité, fraternité ET Neutralité" style="float:left; margin-right:20px" />

<h1>Le serveur (son propriétaire en fait) n'a pas envie de vous laisser accéder à cette ressource...</h1>
<h2>Et en même temps, vous l'avez bien cherché...</h2>

<p style="clear:both; text-align:justify; padding-top:50px">Ce nom de
domaine, ainsi que beaucoup d'autres, ont été saisis par les
internautes à la suite d'attaques répétées à l'encontre de la
Neutralité du Net par les pouvoirs publics.</p>
<p style="text-align:justify;">Conduire, financer, gêrer, superviser,
diriger ou proposer une atteinte à la Neutralité du Net revient
basiquement à s'attaquer à la liberté d'expression du peuple et devrait
être considéré comme une atteinte manifeste aux droits de l'Homme.</p>
<p style="text-align:justify;">Il n'y aura aucune suite à cette saisie citoyenne.</p>
<p style="text-align:justify;">Les plages d'adresses IP filtrées sont les suivantes : </p>

<ul>
%s
</ul>
<p>Plus d'informations ici : <a href="http://reflets.info/optimiser-son-internet-a-la-sauce-marland-militello/">Optimiser son Internet à la sauce Marland-Militello</a></p>

</div>
</body>
</html>
EOS
