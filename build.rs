use std::env;

fn main() {
    let target = env::var("TARGET").unwrap();
    if target.contains("wasm") {
        match std::fs::create_dir("dist") {
            Ok(_) => {}
            Err(e) => {
                if e.kind() != std::io::ErrorKind::AlreadyExists {
                    panic!("Failed to create dist directory: {}", e);
                }
            }
        }
        std::fs::copy("build/web/index.html", "dist/index.html")
            .expect("Failed to copy index.html");
    }
}
