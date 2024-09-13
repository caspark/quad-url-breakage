#[macroquad::main("hi")]
async fn main() {
    quad_url::link_open("https://example.com", true);

    macroquad::prelude::info!("Main() ended, woo");
}
