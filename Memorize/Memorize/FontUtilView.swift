//
//  FontUtilView.swift
//  Memorize
//
//  Created by Jimmy Gizmo on 8/17/21.
//

import SwiftUI


let customFonts: (allKinds: [String], allFonts: [String]) = allCustomFontsFinder()

func allCustomFontsFinder() -> (allKinds: [String], allFonts: [String]) {
    
    let allKinds: [String] = UIFont.familyNames.sorted()
    var allFonts: [String] = [String]()
    
    allKinds.forEach { familyItem in
        
        UIFont.fontNames(forFamilyName: familyItem).forEach { item in allFonts.append(item) }
        
    }
    return (allKinds: allKinds, allFonts: allFonts)
}  // allCustomFontsFinder


struct FontUtilView: View {
    
    var body: some View {
        
        List {
            ForEach(customFonts.allFonts, id: \.self) { item in
                HStack {
                    
                    Text(item)
                        .font(Font.custom(item, size: 20))
                        .onTapGesture { print(item) }
                    
                    Spacer()
                    
                    Button(action: { let pasteboard = UIPasteboard.general; pasteboard.string = item }, label: {
                        Image(systemName: "doc.on.doc")
                    })
                    
                }  // HStack
                
            }  // ForEach
        }  // List
        .padding()
        .onAppear() {
            print("count Of CustomFontKinds:", customFonts.allKinds.count)
            print("count Of AllCustomFonts:", customFonts.allFonts.count)
        }
        
    }  // var body View
}  // FontUtilView


struct FontUtilView_Previews: PreviewProvider {
    static var previews: some View {
        FontUtilView()
    }
}

