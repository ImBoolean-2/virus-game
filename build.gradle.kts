plugins {
    kotlin("jvm") version "2.1.10"
    id("com.utopia-rise.godot-kotlin-jvm") version "0.13.1-4.4.1"
}

repositories {
    mavenLocal()
    mavenCentral()
    google()
}

godot {
    registrationFileBaseDir.set(projectDir.resolve("scripts"))
    isRegistrationFileGenerationEnabled.set(true)
}