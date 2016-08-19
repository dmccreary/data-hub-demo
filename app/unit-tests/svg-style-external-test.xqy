xquery version "1.0-ml";

let $style := doc('/unit-tests/svg-style-external-test.css')

return
<svg xmlns="http://www.w3.org/2000/svg">
   <style type="text/css">
   {$style}
   </style>
   <g style="fill-opacity:0.7;">
      <circle cx="6.5cm" cy="2cm" r="100" style="fill:red;" transform="translate(0,50)" />
      <circle cx="6.5cm" cy="2cm" r="100" style="fill:blue;" transform="translate(70,150)" />
      <circle cx="6.5cm" cy="2cm" r="100" style="fill:green;" transform="translate(-70,150)"/>
   </g>
   <text x="10" y="400">To pass the external style import test the circles must have black outlines and change opacity on hover.</text>
</svg>
