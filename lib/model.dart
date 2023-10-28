import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

class ModelPage extends StatefulWidget {
  const ModelPage({
    Key? key,
  }) : super(key: key);

  @override
  _ModelPageState createState() => _ModelPageState();
}

class _ModelPageState extends State<ModelPage> {
  @override
  Widget build(BuildContext context) {
    const String CustomCss = '''
 .hotspot{
          display: block;
          width: 10px;
          height: 10px;
          border-radius: 10px;
          border: none;
          background-color: red;
          box-sizing: border-box;
          pointer-events: none;
        }


.hotspot[slot="hotspot-backHeadShift"]{
          --min-hotspot-opacity: 0;
          background-color: green;
        }


          .annotation{
            display: none; 
          background-color: #888888;
          position: absolute;
          transform: translate(10px, 10px);
          border-radius: 10px;
          padding: 5px;
        }

        :not(:defined) > * {
          display: none;
        }

''';

    String customHTML() {
      return '''

        <button class="hotspot" slot="hotspot-backHeadShift" data-position="0.10370809143793136m 1.570910077466132m -0.0283548412644928m" data-normal="0.9780379581970103m -0.045808001135835046m -0.20333071425085403m" data-orbit="10.89188deg 119.9775deg 0.03543022m" data-target="-0.1053838m 0.01610652m 0.1076345m"
        >
        <div class="annotation">Left head shift&deg;</div>
        </button>


<script type="module">
          // JavaScript to handle showing and hiding annotations on hotspot click
          const model=document.querySelector('#female');

           const annotationClicked = (annotation) => {
            console.log("🔴")
    let dataset = annotation.dataset;
    model.cameraTarget = dataset.target;
    model.cameraOrbit = dataset.orbit;
    model.fieldOfView = '45deg';
  }

       model.querySelectorAll('button').forEach((hotspot) => {
    hotspot.addEventListener('touchend', () => annotationClicked(hotspot));
  });
      
        </script>



        ''';
    }

    String css = '''
            console.log("🥬")

          // JavaScript to handle showing and hiding annotations on hotspot click
          const model=document.querySelector('#female');
            console.log(model)

           const annotationClicked = (annotation) => {
    let dataset = annotation.dataset;
    model.cameraTarget = dataset.target;
    model.cameraOrbit = dataset.orbit;
    model.fieldOfView = '45deg';
  }

       model.querySelectorAll('button').forEach((hotspot) => {
            console.log("🔴");
hotspot.click()
            console.log();

    hotspot.addEventListener('click tap touchstart', (e) =>{
      
            console.log("🔴");
      
       annotationClicked(hotspot)
       
        e.preventDefault();
       });
  });
      



        ''';

    return ModelViewer(
      backgroundColor: Color.fromARGB(0xFF, 0xEE, 0xEE, 0xEE),
      src: 'assets/3d_models/Female.glb',
      iosSrc: 'https://modelviewer.dev/shared-assets/models/Astronaut.usdz',
      disableZoom: false,
      relatedCss: CustomCss,
      innerModelViewerHtml: customHTML(),
      id: "female",
      touchAction: TouchAction.none,
      relatedJs: css,
    );
  }
}
