{ pkgs, ... }: {
  home.packages = with pkgs; [
    # digital audio workstation
    bitwig-studio3
    musescore
    picoloop
    zrythm

    # jackaudio
    a2jmidid
    carla
    jack2Full
    jack_capture
    japa
    qjackctl

    # plugins
    ChowKick
    adlplug
    aeolus
    ams
    bespokesynth
    bristol
    calf
    dexed
    drumgizmo
    drumkv1
    fluidsynth
    fmsynth
    freepats
    geonkick
    gnaural
    helm
    hydrogen
    industrializer
    linuxsampler
    opnplug
    oxefmsynth
    padthv1
    qsynth
    samplv1
    sorcer
    sunvox
    surge
    surge-XT
    synthv1
    vcv-rack
    x42-avldrums
    x42-gmsynth
    yoshimi
    zyn-fusion
  ];
}
