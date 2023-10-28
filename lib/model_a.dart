import 'package:flutter/material.dart';
import 'package:model_viewer_plus/model_viewer_plus.dart';

class ModelPageA extends StatefulWidget {
  const ModelPageA({
    Key? key,
  }) : super(key: key);

  @override
  _ModelPageAState createState() => _ModelPageAState();
}

class _ModelPageAState extends State<ModelPageA> {
  @override
  Widget build(BuildContext context) {
    const String CustomCss = '''
  .anchor{
    display: none;
  }

  .lineContainer{
    pointer-events: none;
    display: block;
  }

  .line{
    stroke: #16a5e6;
    stroke-width: 2;
    stroke-dasharray: 2
  }

  #container{
    position: absolute;
    display: flex;
    justify-content: space-evenly;
    bottom: 8px;
    left: 8px;
    width: 100%;
  }

  .label{
    background: #fff;
    border-radius: 4px;
    border: none;
    box-sizing: border-box;
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.25);
    color: rgba(0, 0, 0, 0.8);
    display: block;
    font-family: Futura, Helvetica Neue, sans-serif;
    font-size: 18px;
    font-weight: 700;
    max-width: 128px;
    padding: 0.5em 1em;
    bottom: 10px;
    pointer-events: none;
  }

  #animation-demo::part(default-ar-button){
    bottom: 64px;
  }

  /* This keeps child nodes hidden while the element loads */
  :not(:defined) > * {
    display: none;

''';

    String customHTML() {
      return '''
  <div slot="hotspot-nose" class="anchor" data-surface="0 0 228 113 111 0.217 0.341 0.442"></div>
  <div slot="hotspot-hoof" class="anchor" data-surface="0 0 752 733 735 0.132 0.379 0.489"></div>
  <div slot="hotspot-tail" class="anchor" data-surface="0 0 220 221 222 0.405 0.061 0.534"></div>
  <svg id="lines" width="100%" height="100%" xmlns="http://www.w3.org/2000/svg" class="lineContainer">
    <line class="line"></line>
    <line class="line"></line>
    <line class="line"></line>
  </svg>

  <div id="container">
    <button id="nose" class="label">Head</button>
    <button id="hoof" class="label">Shoulder</button>
    <button id="tail" class="label">Neck</button>
  </div>

  
<script type="module">
  const modelViewer1 = document.querySelector('#female');
  const lines = modelViewer1.querySelectorAll('line');
  let baseRect;
  let noseRect;
  let hoofRect;
  let tailRect;
  
  function onResize(){
    baseRect = modelViewer1.getBoundingClientRect();
    noseRect = document.querySelector('#nose').getBoundingClientRect();
    hoofRect = document.querySelector('#hoof').getBoundingClientRect();
    tailRect = document.querySelector('#tail').getBoundingClientRect();
  }

  window.addEventListener("resize", onResize);

  modelViewer1.addEventListener('ar-status', onResize);

  modelViewer1.addEventListener('load', () => {
    onResize();
    // update svg
    function drawLine(svgLine, name, rect) {
      const hotspot = modelViewer1.queryHotspot('hotspot-' + name);
      svgLine.setAttribute('x1', hotspot.canvasPosition.x);
      svgLine.setAttribute('y1', hotspot.canvasPosition.y);
      svgLine.setAttribute('x2', (rect.left + rect.right) / 2 - baseRect.left);
      svgLine.setAttribute('y2', rect.top - baseRect.top);
    }

    // use requestAnimationFrame to update with renderer
    const startSVGRenderLoop = () => {
      drawLine(lines[0], 'nose', noseRect);
      drawLine(lines[1], 'hoof', hoofRect);
      drawLine(lines[2], 'tail', tailRect);
      requestAnimationFrame(startSVGRenderLoop);
    };

    startSVGRenderLoop();
  });
</script>



        ''';
    }

    return ModelViewer(
      backgroundColor: Color.fromARGB(0xFF, 0xEE, 0xEE, 0xEE),
      src: 'assets/3d_models/Female.glb',
      iosSrc: 'https://modelviewer.dev/shared-assets/models/Astronaut.usdz',
      disableZoom: false,
      relatedCss: CustomCss,
      innerModelViewerHtml: customHTML(),
      id: "female",
      touchAction: TouchAction.none,
    );
  }
}
