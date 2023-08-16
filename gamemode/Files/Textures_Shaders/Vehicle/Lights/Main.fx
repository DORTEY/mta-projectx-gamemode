texture CustomLights;

technique hello
{
    pass P0
    {
        Texture[0] = CustomLights;
    }
}
