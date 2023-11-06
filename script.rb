class Node
    attr_accessor :value, :left_child, :right_child

    def initialize(value)
        @value = value
        @left_child = nil
        @right_child = nil
    end

end

class Tree
    attr_accessor :root, :size, :array

    def initialize(array)
       sorted_array = array.uniq.sort
       @root = build_tree(sorted_array, 0, sorted_array.size - 1)
    end

    def build_tree(array, first_index, last_index)
        return nil if first_index > last_index

        middle_index = (first_index + last_index) / 2
        root = Node.new(array[middle_index])
        root.left_child = build_tree(array, first_index, middle_index - 1)
        root.right_child = build_tree(array, middle_index + 1, last_index)
        root
      end

      def pretty_print(node = @root, prefix = '', is_left = true)
        pretty_print(node.right_child, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right_child
        puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
        pretty_print(node.left_child, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left_child
      end
end

tree = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])
tree.pretty_print
