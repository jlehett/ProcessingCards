class ColorPass implements Pass {
    PShader shader;

    public ColorPass() {
        shader = loadShader("ColorFrag.glsl");
    }

    public void setUniforms(float cardWidth, float cardHeight) {
        shader.set("resY", cardHeight);
        shader.set("resX", cardWidth);
    }

    @Override
    public void prepare(Supervisor supervisor) {
        // Set parameters of the shader if needed
    }

    @Override
    public void apply(Supervisor supervisor) {
        PGraphics pass = supervisor.getNextPass();
        supervisor.clearPass(pass);

        pass.beginDraw();
        pass.shader(shader);
        pass.image(supervisor.getCurrentPass(), 0, 0);
        pass.endDraw();
    }
}