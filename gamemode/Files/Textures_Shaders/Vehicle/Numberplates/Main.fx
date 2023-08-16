texture CustomNumbplates;

technique TexReplace
{
    pass P0
    {
        Texture[0] = CustomNumbplates;
    }
}
