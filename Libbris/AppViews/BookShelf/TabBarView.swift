//
//  TabBarView.swift
//  Libbris
//
//  Created by 郝育宽 on 2021-09-14.
//

import SwiftUI

struct TabBarView: View {
    @Binding var tabIndex: Tabs
    @State var hotText = localizedString(text: strHot)
    @State var recommendText = localizedString(text: strRecommend)
    @State var newText = localizedString(text: strNew)
       var body: some View {
           HStack(spacing: 20) {
            TabBarButton(text: hotText, isSelected: .constant(tabIndex == .hot))
                .onTapGesture { onButtonTapped(index: .hot) }
            TabBarButton(text: recommendText, isSelected: .constant(tabIndex == .recommend))
                .onTapGesture { onButtonTapped(index: .recommend) }
            TabBarButton(text: newText, isSelected: .constant(tabIndex == .new))
                .onTapGesture { onButtonTapped(index: .new) }
               Spacer()
           }
           .border(width: 1, edges: [.bottom], color: .black)
           .onReceive(NotificationCenter.default.publisher(for: NSNotification.Name("switchLanguage")),
                      perform: { _ in
            self.hotText = localizedString(text: strHot)
            self.recommendText = localizedString(text: strRecommend)
            self.newText = localizedString(text: strNew)
        })
       }
       private func onButtonTapped(index: Tabs) {
           withAnimation { tabIndex = index }
       }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView(tabIndex: .constant(.hot))
    }
}

struct TabBarButton: View {
    let text: String
    @Binding var isSelected: Bool
    var body: some View {
        Text(text)
            .fontWeight(isSelected ? .heavy : .regular)
            .font(.custom("Dosis-Bold", size: 16))
            .padding(.bottom, 10)
            .border(width: isSelected ? 2 : 1, edges: [.bottom], color: .black)
    }
}

extension View {
    func border(width: CGFloat, edges: [Edge], color: SwiftUI.Color) -> some View {
        overlay(EdgeBorder(width: width, edges: edges).foregroundColor(color))
    }
}

struct EdgeBorder: Shape {

    var width: CGFloat
    var edges: [Edge]

    func path(in rect: CGRect) -> Path {
        var path = Path()
        for edge in edges {
            var varX: CGFloat {
                switch edge {
                case .top, .bottom, .leading: return rect.minX
                case .trailing: return rect.maxX - width
                }
            }

            var varY: CGFloat {
                switch edge {
                case .top, .leading, .trailing: return rect.minY
                case .bottom: return rect.maxY - width
                }
            }

            var wid: CGFloat {
                switch edge {
                case .top, .bottom: return rect.width
                case .leading, .trailing: return self.width
                }
            }

            var hei: CGFloat {
                switch edge {
                case .top, .bottom: return self.width
                case .leading, .trailing: return rect.height
                }
            }
            path.addPath(Path(CGRect(x: varX, y: varY, width: wid, height: hei)))
        }
        return path
    }
}
