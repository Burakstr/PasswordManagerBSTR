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
                        .frame(width: 80, height: 80)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .shadow(radius: 5)
                } else {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.white)
                        .frame(height: 80)
                        .shadow(radius: 5)
                }

                Text(name)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    AppIconView(name: "Facebook", category: "Social Media")
}
