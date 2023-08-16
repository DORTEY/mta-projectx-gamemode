texture CustomPaintjobs;

technique TexReplace
{
    pass P0
    {
        Texture[0] = CustomPaintjobs;
    }
}
