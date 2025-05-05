package demo

import "core:fmt"
import "core:math/rand"
import "vendor:sdl3"

window: ^sdl3.Window
renderer: ^sdl3.Renderer

run :: proc() {
    if !sdl3.Init({.EVENTS, .VIDEO}) {
        panic("Failed to initialize SDL3")
    }

    window = sdl3.CreateWindow("Demo Window", 800, 500, {.INPUT_FOCUS})

    if window == nil {
        panic("Failed to create the window")
    }

    renderer = sdl3.CreateRenderer(window, nil)

    if renderer == nil {
        panic("Failed to create the renderer")
    }

    // Depends on hardware, e.g. this should be "metal" on modern Mac systems
    fmt.printfln("Graphics driver: %v", sdl3.GetRenderDriver(0))

    // Some drivers will always v-sync, this explicitly enables it
    sdl3.SetRenderVSync(renderer, 1)

    event: sdl3.Event

    main: for {
        // Handle any incoming system events
        for sdl3.PollEvent(&event) {
            if event.type == .QUIT {
                break main
            }
        }

        // Clear the previous frame
        sdl3.SetRenderDrawColor(renderer, 0, 0, 0, 255)
        sdl3.RenderClear(renderer)

        draw()

        // Commit the current frame, this will block until the next v-sync
        sdl3.RenderPresent(renderer)
    }

    sdl3.DestroyRenderer(renderer)
    sdl3.DestroyWindow(window)
    sdl3.Quit()
}

@(private)
draw :: proc() {
    sdl3.SetRenderDrawColor(renderer, 80, 40, 60, 255)
    sdl3.SetRenderDrawBlendMode(renderer, {.ADD})

    rect: sdl3.FRect
    rect.w = 20
    rect.h = 20

    for i := 0; i < 4000; i += 1 {
        rect.x = 780 * rand.float32()
        rect.y = 480 * rand.float32()

        sdl3.RenderFillRect(renderer, &rect)
    }
}
