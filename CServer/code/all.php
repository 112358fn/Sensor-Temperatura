<?php
//connexion a la base de datos
try
  {
    $bdd = new PDO('mysql:host=localhost;dbname=proyecto', 'root', '');
  }
catch(Exception $e)
  {
    die('Erreur : '.$e->getMessage());
  }


// Los datos del sensor 1
$req = $bdd->query('SELECT id, temp, fecha FROM temperaturas where id_sensor=1');
//Initiar una tabla
$resultat1=array();
$j=1;
while ($donnees = $req->fetch())
  {//Poner los resultados en una tabla

    $resultat1[$j]= array($donnees['id'],$donnees['fecha'],$donnees['temp']);
    $j++;
  }
  $req->closeCursor();

// Los datos del sensor 2
$req= $bdd->query('SELECT id, temp, fecha FROM temperaturas where id_sensor=2');

$resultat2=array();
$j=1;
while ($donnees = $req->fetch())
  {
    //transformar las fechas (se puede hacer despues como en el sensor 1)
    $v=strtotime($donnees['fecha']);
    $resultat2[$j]= array($donnees['id'],$v,$donnees['temp']);
    $j++;
  }
  $req->closeCursor();


// Los datos del sensor 3
$req= $bdd->query('SELECT id, temp, fecha FROM temperaturas where id_sensor=3');

$resultat3=array();
$j=1;
while ($donnees = $req->fetch())
  {
    $v=strtotime($donnees['fecha']);
    $resultat3[$j]= array($donnees['id'],$v,$donnees['temp']);
    $j++;
  }
  $req->closeCursor();

// Los datos del sensor  4
$req = $bdd->query('SELECT id, temp, fecha FROM temperaturas where id_sensor=4');

$resultat4=array();
$j=1;
while ($donnees = $req->fetch())
  {

    $resultat4[$j]= array($donnees['id'],$donnees['fecha'],$donnees['temp']);
    $j++;
  }
  $req->closeCursor();

// Los datos del sensor 5
$req= $bdd->query('SELECT id, temp, fecha FROM temperaturas where id_sensor=5');

$resultat5=array();
$j=1;
while ($donnees = $req->fetch())
  {
    $v=strtotime($donnees['fecha']);
    $resultat5[$j]= array($donnees['id'],$v,$donnees['temp']);
    $j++;
  }
  $req->closeCursor();


// Los datos del sensor  6
$req= $bdd->query('SELECT id, temp, fecha FROM temperaturas where id_sensor=6');

$resultat6=array();
$j=1;
while ($donnees = $req->fetch())
  {
    $v=strtotime($donnees['fecha']);
    $resultat6[$j]= array($donnees['id'],$v,$donnees['temp']);
    $j++;
  }
  $req->closeCursor();

//Si hay mas sensores, pueden copiar una recuperation de datos y cabiar el id del sensor.
//Tambien, deben cambiar el nombre de la tabla $resultat
  // y no olbidar de poner une nuevo sensor en la parte Javascript

?>




<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
 <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <title>Servidor 2</title>
    <link href="layout.css" rel="stylesheet" type="text/css"></link>
    <!--[if IE]><script language="javascript" type="text/javascript" src="excanvas.pack.js"></script><![endif]-->
    <script language="javascript" type="text/javascript" src="jquery.js"></script>
    <script language="javascript" type="text/javascript" src="jquery.flot.js"></script>
 </head>
    <body>
   

          <h3>Todos</h3>
            <!--Figar el grafico-->
            <div id="placeholder" style="width:600px;height:300px;"></div>
            <h4>Fijar los sensores:</h4>

            <p id="choices">Comprobar para seleccionar</p>

            <h4>Autorizar el sobrevuelo con el Ratón</h4>
            <p>Permite fijar los datos (fechas y valor)</p>
            <p><input id="enableTooltip" type="checkbox">Si</p>



<script id="source" language="javascript" type="text/javascript">
$(function () {
 
    var datasets = {
            
        "Sensor 1": {
            label: "Sensor 1",
            data: [<?php
            
            $taille = sizeof($resultat1);
            for($i=1; $i<=$taille; $i++)
            { 
              ?>[<?php
              $v=strtotime($resultat1[$i][1]);
              echo $v;
              
              

              ?>,<?php
              echo $resultat1[$i][2];
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

            for($i=1; $i<=$taille; $i++)
            { 
              ?>[<?php
              
             echo $resultat2[$i][1];
               


              ?>,<?php
              echo $resultat2[$i][2]; 
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
      
            for($i=1; $i<=$taille; $i++)
            { 
              ?>[<?php
              
              echo $resultat3[$i][1];


              ?>,<?php
              echo $resultat3[$i][2]; 
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

            for($i=1; $i<=$taille; $i++)
            { 
              ?>[<?php
              $v=strtotime($resultat4[$i][1]);
              echo $v;
              
              

              ?>,<?php
              echo $resultat4[$i][2]; 
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

            for($i=1; $i<=$taille; $i++)
            { 
              ?>[<?php
              
             echo $resultat5[$i][1];
               


              ?>,<?php
              echo $resultat5[$i][2]; 
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

            for($i=1; $i<=$taille; $i++)
            { 
              ?>[<?php
              
              echo $resultat6[$i][1];


              ?>,<?php
              echo $resultat6[$i][2]; 
              ?>]<?php
               if ($i<$taille)
              {
                ?>,<?php
              }
            }

            ?>]
        }

        //Si hay mas sensores, deben copiar una recuperation de los resultados cambiar el nombre de la tabla $resultat
         // y no olbidar de preguntar la base de datos antes

    };

    // Lo que permite de elegir que curba figar
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

            $("#placeholder").bind(function (event, pos, item) {
                if (item) { 
                    plot.highlight(item.series, item.datapoint);
                }
    });
    }

    plotAccordingToChoices();
});
</script>

 </body>
</html>
