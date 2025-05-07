
extern Image mask;
extern Image entities;

vec4 effect(vec4 color,Image image, vec2 uvs, vec2 screen_coords){

    vec4 mapPixel = Texel(image, uvs);
    vec4 entityPixel = Texel(entities,uvs);
    vec4 maskPixel = Texel(mask,uvs);

    if(entityPixel != vec4(0,0,0,0) && maskPixel == vec4(1,1,1,1)){
        return entityPixel * color;
    }

    return mapPixel * color * maskPixel;
  
}