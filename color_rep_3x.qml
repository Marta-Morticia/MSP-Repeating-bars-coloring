import QtQuick 2.1
import MuseScore 3.0

MuseScore {
      version:  "1.0"
      description: "Plugin que colorea barras de repetición"
      /*
      Idea y programación: V. Carrasco & M. Pla
      */
      menuPath: "Plugins.Color_Rep"
      
      property string black : "#000000"
      property string red : "#ff0000"
      
       property variant colors : [ // "#rrggbb" with rr, gg, and bb being the hex values for red, green, and blue, respectively
               "#ff0000", // rojo
               "#0000ff", // azul
               "#ff6347", // tomate
               "#008000", // verde
               "#ffa500", // naranja
               "#008b8b", // cyan
               "#5500ff", // violeta
               "#aa007f", // fucsia
               "#aa5500", // marron
               "#aa0000", // rojo oscuro
               "#8d5ba6", // violeta claro
               "#cf3e96"  // rosa
               ]

              
               
               
      onRun: 
      {       
            var cursor = curScore.newCursor();      
            cursor.rewind(0);
            
            for (var track = 0; track < /*curScore.ntracks*/1; ++track) {
                  //console.log('===== Track ' + track + ' =====');
                  
                
                  
                  var segment = curScore.firstSegment();
                  var cont = 0;
                  
                  while (segment) {
                              
                        var element = segment.elementAt(track);
                        if (element) {
                              var type = element.type;
                                                             
                                    
                              if (element._name() == "BarLine")
                              {
                                    if ((element.subtypeName() == "start-repeat")
                                    || (element.subtypeName() == "end-repeat")  
                                    ||  (element.subtypeName() == "end-start-repeat") 
//                                    || (element.subtypeName() == "end") 
                                    )
                                    {
                                         /* if (element.color == black) element.color = red;
                                          else element.color = black;*/
                                          if (element.color == black && (element.subtypeName() == "start-repeat"))
                                          {
                                                element.color = colors[cont];
                                          }
                                          else if (element.color == black && (element.subtypeName() == "end-start-repeat"))
                                          {
                                                 element.color = colors[cont];
                                          }
                                          else if (element.color == black && (element.subtypeName() == "end-repeat"))
                                          {
                                                 element.color = colors[cont];
                                                 cont++;
                                                 if (cont == 11) cont = 0;
                                          }
                                          else
                                                element.color = black;
                                    }
                              }
                              
                        }
                        segment = segment.next;
                  } 
                  
                  
            }
                      
          Qt.quit();  

       }
}