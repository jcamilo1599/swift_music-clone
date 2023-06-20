//
//  SheetView.swift
//  MusicClone
//
//  Created by Juan Camilo Marín Ochoa on 30/04/23.
//

import SwiftUI

struct SheetView: View {
    // Binding para expandir/colapsar la vista
    @Binding var expandSheet: Bool
    
    // ID para la animación de transición
    var animation: Namespace.ID
    
    // Estado interno para la animación de contenido y el desplazamiento vertical
    @State private var animateContent = false
    @State private var offsetY: CGFloat = 0
    
    var body: some View {
        GeometryReader { geometry in
            let size = geometry.size
            let safeArea = geometry.safeAreaInsets
            let dragProgress = 1.0 - (offsetY / (size.height * 0.5))
            let cornerProgress = max(0, dragProgress)
            let image = UIImage(named: "queen")
            
            ZStack {
                RoundedRectangle(
                    cornerRadius: animateContent ? deviceCornerRadius * cornerProgress : 0,
                    style: .continuous
                )
                .fill(.ultraThickMaterial)
                .overlay(content: {
                    RoundedRectangle(
                        cornerRadius: animateContent ? deviceCornerRadius * cornerProgress : 0,
                        style: .continuous
                    )
                    .fill(Color((image?.averageColor)!))
                    .opacity(animateContent ? 1 : 0)
                })
                .overlay(alignment: .top) {
                    CurrentPlaybackView(expandSheet: $expandSheet, animation: animation)
                        .opacity(animateContent ? 0 : 1)
                }
                .matchedGeometryEffect(id: EffectsIds.close, in: animation)
                
                VStack(spacing: 15) {
                    VStack {
                        Button(action: {
                            withAnimation(.easeInOut(duration: 0.3)) {
                                expandSheet = false
                                animateContent = false
                            }
                        }) {
                            Capsule()
                                .fill(.gray)
                                .frame(width: 40, height: 5)
                                .opacity(animateContent ? cornerProgress : 0)
                                .offset(y: animateContent ? 0 : size.height)
                                .clipped()
                                .padding(.top, 6)
                        }
                        
                        GeometryReader { albumImageGeometry in
                            let albumImageSize = albumImageGeometry.size
                            
                            Image(uiImage: image!)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: albumImageSize.width, height: albumImageSize.height)
                                .clipShape(RoundedRectangle(cornerRadius: animateContent ? 15 : 5, style: .continuous))
                                .shadow(color: .black.opacity(0.3), radius: 16, x: 0, y: 20)
                            
                        }
                        .matchedGeometryEffect(id: EffectsIds.open, in: animation)
                        .frame(width: size.width - 45, height: size.width - 45)
                        .padding(.vertical)
                    }
                    
                    PlayerView(size)
                        .offset(y: animateContent ? 0 : size.height)
                        .padding(.horizontal, 32)
                        .padding(.top, 20)
                }
                .padding(.top, safeArea.top + (safeArea.bottom == 0 ? 10 : 0))
                .padding(.bottom, safeArea.bottom == 0 ? 10 : safeArea.bottom)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                .clipped()
            }
            .contentShape(Rectangle())
            .offset(y: offsetY)
            .gesture(
                DragGesture()
                    .onChanged({ value in
                        let translationY = value.translation.height
                        offsetY = (translationY > 0 ? translationY : 0)
                    }).onEnded({ value in
                        withAnimation(.easeInOut(duration: 0.3)) {
                            if offsetY > size.height * 0.4 {
                                // Si la posición proyectada supera el 40% de la altura de la pantalla
                                expandSheet = false
                                animateContent = false
                            } else {
                                offsetY = .zero
                            }
                        }
                    })
            )
            .ignoresSafeArea(.container, edges: .all)
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 0.35)) {
                animateContent = true
            }
        }
    }
    
    /// Vista del reproductor (contiene toda la información de la canción con controles de reproducción)
    @ViewBuilder
    func PlayerView(_ mainSize: CGSize) -> some View {
        GeometryReader {
            let size = $0.size
            let spacing = size.height * 0.04
            
            VStack(spacing: spacing) {
                VStack(spacing: spacing) {
                    HStack(alignment: .center, spacing: 16) {
                        VStack(alignment: .leading) {
                            AutoScrollingTextView(title: "Under Pressure (feat. David Bowie)")
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .mask(
                                    LinearGradient(
                                        gradient: Gradient(colors: [.clear, .black]),
                                        startPoint: UnitPoint(x: 1.0, y: 0.5),
                                        endPoint: UnitPoint(x: 0.9, y: 0.5)
                                    )
                                )
                                .frame(height: 24)
                            
                            Text("Queen")
                                .font(.system(size: 19))
                                .foregroundColor(.white.opacity(0.8))
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Button {
                            
                        } label: {
                            Image(systemName: "ellipsis")
                                .foregroundColor(.white)
                                .fontWeight(.heavy)
                                .padding(10)
                                .background {
                                    Circle()
                                        .fill(.white.opacity(0.2))
                                }
                        }
                    }
                    
                    // Indicador del tiempo
                    IndicatorView(
                        progress: .constant(0.33),
                        height: .constant(8)
                    )
                    
                    HStack {
                        Text("1:19")
                            .font(.caption)
                            .foregroundColor(.white.opacity(0.4))
                        
                        Spacer()
                        
                        LosslessView()
                        
                        Spacer()
                        
                        Text("-2:37")
                            .font(.caption)
                            .foregroundColor(.white.opacity(0.4))
                    }
                }
                .frame(height: size.height / 2.5, alignment: .top)
                
                // Controles
                HStack(spacing: size.width * 0.18) {
                    Button {
                        
                    } label: {
                        Image(systemName: "backward.fill")
                            .font(size.height < 300 ? .title3 : .title)
                    }
                    
                    Button {
                    } label: {
                        Image(systemName: "pause.fill")
                            .font(size.height < 300 ? .largeTitle : .system(size: 50))
                    }
                    
                    Button {
                    } label: {
                        Image(systemName: "forward.fill")
                            .font(size.height < 300 ? .title3 : .title)
                    }
                }
                .foregroundColor(.white)
                .frame(maxHeight: .infinity)
                
                // Control de volumen
                VStack(spacing: spacing) {
                    HStack(spacing: 15) {
                        Image(systemName: "speaker.fill")
                            .foregroundColor(.gray)
                        
                        IndicatorView(
                            progress: .constant(0.5),
                            height: .constant(6)
                        )
                        
                        Image(systemName: "speaker.wave.3.fill")
                            .foregroundColor(.gray)
                    }
                    
                    HStack(alignment: .top) {
                        Button {
                        } label: {
                            Image(systemName: "quote.bubble")
                                .font(.title2)
                        }
                        
                        VStack(spacing: 6) {
                            Button {
                            } label: {
                                Image(systemName: "airpodspro")
                                    .font(.title2)
                            }
                            
                            Text("AirPods Pro 2 de Juan Camilo")
                                .font(.system(size: 12, weight: .medium))
                        }
                        
                        Button {
                        } label: {
                            Image(systemName: "list.bullet")
                                .font(.title2)
                        }
                    }
                    .foregroundColor(.white)
                    .blendMode(.overlay)
                    .padding(.top, spacing)
                }
            }
        }
    }
    
    /// Obtiene el radio de borde de la pantalla del dispositivo.
    var deviceCornerRadius: CGFloat {
        let key = "_displayCornerRadius"
        
        if let screen = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.screen {
            if let cornerRadius = screen.value(forKey: key) as? CGFloat {
                return cornerRadius
            }
        }
        
        return 0
    }
}

struct SheetView_Previews: PreviewProvider {
    @Namespace static private var previewNamespace
    
    static var previews: some View {
        SheetView(expandSheet: .constant(true), animation: previewNamespace)
    }
}
