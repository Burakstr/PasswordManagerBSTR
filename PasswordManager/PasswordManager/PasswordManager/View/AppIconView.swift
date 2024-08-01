import SwiftUI

struct AppIconView: View {
    var name: String
    var category: String
    @EnvironmentObject var viewModel: AddSocialMediaViewModel

    var body: some View {
        NavigationLink(destination: PasswordAddView(selectedImage: name, category: category)) {
            VStack {
                if let uiImage = UIImage(named: name) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 60, height: 60)
                        .background(Color.white)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.gray, lineWidth: 2))
                        .shadow(radius: 5)
                } else {
                    Circle()
                        .fill(Color.gray)
                        .frame(width: 60, height: 60)
                        .overlay(Text("No Image").foregroundColor(.white))
                        .shadow(radius: 5)
                }

                Text(name)
                    .font(.caption)
                    .foregroundColor(.white)
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    AppIconView(name: "Facebook", category: "Social Media")
}
