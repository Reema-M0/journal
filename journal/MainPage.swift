import SwiftUI

struct MainPage: View {
    @State private var showingNewJournal = false
    @State private var journals: [(title: String, content: String)] = []
    @State private var editIndex: Int? = nil
    @State private var searchText: String = ""
    @State private var bookmarkedIndices: Set<Int> = []

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack {
                header
                searchField
                journalSection
                Spacer()
            }
            .padding()
        }
        .sheet(isPresented: $showingNewJournal) {
            if let index = editIndex {
                NewJournal(onSave: { title, content in
                    journals[index] = (title: title, content: content)
                }, title: journals[index].title, content: journals[index].content)
            } else {
                NewJournal { title, content in
                    journals.append((title: title, content: content))
                }
            }
        }
    }

    private var header: some View {
        HStack {
            Text("Journal")
                .font(.largeTitle)
                .foregroundColor(.white)
            Spacer()
            actionButtons
        }
        .padding()
    }

    private var actionButtons: some View {
        HStack(spacing: 20) {
            button(action: {
                editIndex = nil
                showingNewJournal.toggle()
            }, systemImage: "plus")
            button(action: {}, systemImage: "line.horizontal.3.decrease")
        }
    }

    private func button(action: @escaping () -> Void, systemImage: String) -> some View {
        Button(action: action) {
            Circle()
                .fill(Color(hex: "1F1F22"))
                .frame(width: 30, height: 30)
                .overlay(Image(systemName: systemImage).foregroundColor(.purple1))
        }
    }

    private var searchField: some View {
        HStack {
            Image(systemName: "magnifyingglass").foregroundColor(.gray)
            TextField("Search", text: $searchText)
                .foregroundColor(.white)
            Spacer()
            Button(action: {}) {
                Image(systemName: "mic.fill").foregroundColor(.purple1)
            }
        }
        .padding()
        .frame(width: 350.0, height: 40.0)
        .background(Color(hex: "1F1F22"))
        .cornerRadius(15)
    }

    private var journalSection: some View {
        Group {
            if journals.isEmpty {
                EmptyState()
            } else {
                List {
                    ForEach(filteredJournals.indices, id: \.self) { index in
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color(red: 23/255, green: 23/255, blue: 25/255))
                                .frame(width: 350.0, height: 227)
                                .overlay(
                                    VStack(alignment: .leading) {
                                        Text(filteredJournals[index].title)
                                            .font(.largeTitle)
                                            .foregroundColor(.purple1)
                                            .padding(.bottom, 5)

                                        Text("Date here")
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                            .padding(.bottom, 5)

                                        Text(filteredJournals[index].content)
                                            .foregroundColor(.white)
                                            .padding(.bottom, 5)
                                    }
                                    .padding()
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                )
                                .padding(.top, 20)
                                .overlay(
                                    Button(action: {
                                        if bookmarkedIndices.contains(index) {
                                            bookmarkedIndices.remove(index)
                                        } else {
                                            bookmarkedIndices.insert(index)
                                        }
                                    }) {
                                        Image(systemName: bookmarkedIndices.contains(index) ? "bookmark.fill" : "bookmark")
                                            .foregroundColor(bookmarkedIndices.contains(index) ? .purple1 : .gray)
                                            .padding()
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                                )
                        }
                        .swipeActions(edge: .leading) {
                            Button(action: {
                                editIndex = index
                                showingNewJournal.toggle()
                            }) {
                                Label("Edit", systemImage: "pencil")
                                    .foregroundColor(.purple)
                            }
                            .tint(.purple)
                        }
                        .swipeActions(edge: .trailing) {
                            Button(role: .destructive) {
                                journals.remove(at: index)
                            } label: {
                                Label("Delete", systemImage: "trash")
                                    .foregroundColor(.white)
                            }
                            .tint(.red)
                        }
                        .listRowBackground(Color.clear)
                    }
                }
                .listStyle(.plain)
            }
        }
    }
    
    private var filteredJournals: [(title: String, content: String)] {
        if searchText.isEmpty {
            return journals
        } else {
            return journals.filter { journal in
                journal.title.localizedCaseInsensitiveContains(searchText) ||
                journal.content.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
}

#Preview {
    MainPage()
}
