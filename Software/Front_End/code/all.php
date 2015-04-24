<?php
// On se connecte à la base de données
try
  {
    $bdd = new PDO('mysql:host=localhost;dbname=proyecto', 'root', '');
  }
catch(Exception $e)
  {
    die('Erreur : '.$e->getMessage());
  }

// On récupère les données du capteur 1
$req = $bdd->query('SELECT id, temp, fecha FROM temperaturas where id_sensor=1');
//on crée un tableau
$resultat1=array();
$j=1;
while ($donnees = $req->fetch())
  {//on met les résultats de la requete dans le tableau

    $resultat1[$j]= array($donnees['id'],$donnees['fecha'],$donnees['temp']);
    $j++;
  }
  $req->closeCursor();

// On récupère les données du capteur 2
$req= $bdd->query('SELECT id, temp, fecha FROM temperaturas where id_sensor=2');
//on crée un tableau
$resultat2=array();
$j=1;
while ($donnees = $req->fetch())
  {//on met les résultats de la requete dans le tableau
    $putain=strtotime($donnees['fecha']);
    $resultat2[$j]= array($donnees['id'],$putain,$donnees['temp']);
    $j++;
  }
  $req->closeCursor();


// On récupère les données du capteur 3
$req= $bdd->query('SELECT id, temp, fecha FROM temperaturas where id_sensor=3');
//on crée un tableau
$resultat3=array();
$j=1;
while ($donnees = $req->fetch())
  {//on met les résultats de la requete dans le tableau
    $putain=strtotime($donnees['fecha']);
    $resultat3[$j]= array($donnees['id'],$putain,$donnees['temp']);
    $j++;
  }
  $req->closeCursor();

// On récupère les données du capteur 4
$req = $bdd->query('SELECT id, temp, fecha FROM temperaturas where id_sensor=4');
//on crée un tableau
$resultat4=array();
$j=1;
while ($donnees = $req->fetch())
  {//on met les résultats de la requete dans le tableau

    $resultat4[$j]= array($donnees['id'],$donnees['fecha'],$donnees['temp']);
    $j++;
  }
  $req->closeCursor();

// On récupère les données du capteur 5
$req= $bdd->query('SELECT id, temp, fecha FROM temperaturas where id_sensor=5');
//on crée un tableau
$resultat5=array();
$j=1;
while ($donnees = $req->fetch())
  {//on met les résultats de la requete dans le tableau
    $putain=strtotime($donnees['fecha']);
    $resultat5[$j]= array($donnees['id'],$putain,$donnees['temp']);
    $j++;
  }
  $req->closeCursor();


// On récupère les données du capteur 6
$req= $bdd->query('SELECT id, temp, fecha FROM temperaturas where id_sensor=6');
//on crée un tableau
$resultat6=array();
$j=1;
while ($donnees = $req->fetch())
  {//on met les résultats de la requete dans le tableau
    $putain=strtotime($donnees['fecha']);
    $resultat6[$j]= array($donnees['id'],$putain,$donnees['temp']);
    $j++;
  }
  $req->closeCursor();



?>




<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
 <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <title>Servidor 2</title>
    <link href="layout.css" rel="stylesheet" type="text/css"></link>
    <!--[if IE]><script language="javascript" type="text/javascript" src="../excanvas.pack.js"></script><![endif]-->
    <script language="javascript" type="text/javascript" src="../jquery.js"></script>
    <script language="javascript" type="text/javascript" src="../jquery.flot.js"></script>
 </head>
    <body>
   

          <h3>Todos</h3>
            <!--affichage du graphe-->
            <div id="placeholder" style="width:600px;height:300px;"></div>
            <h4>Fijar los sensores:</h4>

            <p id="choices">Comprobar para seleccionar</p>

            <h4>Autorizar el sobrevuelo con el Ratón</h4>
            <p>Permite fijar los datos (fechas y valor)</p>
            <p><input id="enableTooltip" type="checkbox">Si</p>

          <p>A faire : Dates/x derniers/limit = alerte</p>




<script id="source" language="javascript" type="text/javascript">
$(function () {
 
    var datasets = {
            
        "Sensor 1": {
            label: "Sensor 1",
            data: [<?php
            
            $taille = sizeof($resultat1);
            // Parcours du tableau
            for($i=1; $i<=$taille; $i++)
            { 
              ?>[<?php
              $putain=strtotime($resultat1[$i][1]);
              echo $putain;
              
              

              ?>,<?php
              echo $resultat1[$i][2]; // attention valeur à modifier si je n'ai plus l'id dans mon tableau =1
              ?>]<?php
               if ($i<$taille)
              {
                ?>,<?php
              }
            }

            ?>]
        },


        "Sensor 2": {
            label: "Sensor 2",
            data: [<?php
            
            $taille = sizeof($resultat2);
            // Parcours du tableau
            for($i=1; $i<=$taille; $i++)
            { 
              ?>[<?php
              
             echo $resultat2[$i][1];
               


              ?>,<?php
              echo $resultat2[$i][2]; // attention valeur à modifier si je n'ai plus l'id dans mon tableau =1
              ?>]<?php
               if ($i<$taille)
              {
                ?>,<?php
              }
            }

            ?>]
        },

        "Sensor 3": {
            label: "Sensor 3",
            data: [<?php
            
            $taille = sizeof($resultat3);
            // Parcours du tableau
            for($i=1; $i<=$taille; $i++)
            { 
              ?>[<?php
              
              echo $resultat3[$i][1];


              ?>,<?php
              echo $resultat3[$i][2]; // attention valeur à modifier si je n'ai plus l'id dans mon tableau =1
              ?>]<?php
               if ($i<$taille)
              {
                ?>,<?php
              }
            }

            ?>]
        },
        "Sensor 4": {
            label: "Sensor 4",
            data: [<?php
            
            $taille = sizeof($resultat4);
            // Parcours du tableau
            for($i=1; $i<=$taille; $i++)
            { 
              ?>[<?php
              $putain=strtotime($resultat4[$i][1]);
              echo $putain;
              
              

              ?>,<?php
              echo $resultat4[$i][2]; // attention valeur à modifier si je n'ai plus l'id dans mon tableau =1
              ?>]<?php
               if ($i<$taille)
              {
                ?>,<?php
              }
            }

            ?>]
        },


        "Sensor 5": {
            label: "Sensor 5",
            data: [<?php
            
            $taille = sizeof($resultat5);
            // Parcours du tableau
            for($i=1; $i<=$taille; $i++)
            { 
              ?>[<?php
              
             echo $resultat5[$i][1];
               


              ?>,<?php
              echo $resultat5[$i][2]; // attention valeur à modifier si je n'ai plus l'id dans mon tableau =1
              ?>]<?php
               if ($i<$taille)
              {
                ?>,<?php
              }
            }

            ?>]
        },

        "Sensor 6": {
            label: "Sensor 6",
            data: [<?php
            
            $taille = sizeof($resultat6);
            // Parcours du tableau
            for($i=1; $i<=$taille; $i++)
            { 
              ?>[<?php
              
              echo $resultat6[$i][1];


              ?>,<?php
              echo $resultat6[$i][2]; // attention valeur à modifier si je n'ai plus l'id dans mon tableau =1
              ?>]<?php
               if ($i<$taille)
              {
                ?>,<?php
              }
            }

            ?>]
        }

    };

    // Choix de l'affichage des capteurs
    var i = 0;
    $.each(datasets, function(key, val) {
        val.color = i;
        ++i;
    });
    
    //checkboxes 
    var choiceContainer = $("#choices");
    $.each(datasets, function(key, val) {
        choiceContainer.append('<br/><input type="checkbox" name="' + key +
                               '" checked="checked" >' + val.label + '</input>');
    });
    choiceContainer.find("input").click(plotAccordingToChoices);

    
    function plotAccordingToChoices() {
        var data = [];

        choiceContainer.find("input:checked").each(function () {
            var key = $(this).attr("name");
            if (key && datasets[key])
                data.push(datasets[key]);
        });

        if (data.length > 0)
            var plot = $.plot($("#placeholder"), data, 
            {
              lines: { show: true },
              points: { show: true },
              selection: { mode: "xy" }, 
              grid: { hoverable: true, clickable: true },
              xaxis: { mode: "time"}
            });

            function showTooltip(x, y, contents) {
                $('<div id="tooltip">' + contents + '</div>').css( {
                position: 'absolute',
                display: 'none',
                top: y + 5,
                left: x + 5,
                border: '1px solid #fdd',
                padding: '2px',
                'background-color': '#fee',
                opacity: 0.80
            }).appendTo("body").fadeIn(200);
            }

            var previousPoint = null;
            $("#placeholder").bind("plothover", function (event, pos, item) {
                $("#x").text(pos.x.toFixed(2));
                $("#y").text(pos.y.toFixed(2));

                if ($("#enableTooltip:checked").length > 0) {
                    if (item) {
                        if (previousPoint != item.datapoint) {
                            previousPoint = item.datapoint;
                            
                            $("#tooltip").remove();
                            var x = item.datapoint[0].toFixed(2),
                                y = item.datapoint[1].toFixed(2);
                            var d = new Date(x*1000); 
                           

                            showTooltip(item.pageX, item.pageY,
                                        item.series.label  + ": El " + (d.getDate() + '/' + (d.getMonth()+1) + '/' + d.getFullYear())+ " a las " + ((d.getHours()+4) + ':' + d.getMinutes() + ':' + d.getSeconds()) + " era " + y + "°");
                        }
                    }
                    else {
                        $("#tooltip").remove();
                        previousPoint = null;            
                    }
                }
            });
            $("#placeholder").bind("plotclick", function (event, pos, item) {
                if (item) { // cette partie ne concerne que le fait de cliquer sur un point de la courbe?
                    $("#clickdata").text("You clicked point " + item.dataIndex + " in " + item.series.label + ".");
                    plot.highlight(item.series, item.datapoint);
                }
    });
    }

    plotAccordingToChoices();
});
</script>

 </body>
</html>
