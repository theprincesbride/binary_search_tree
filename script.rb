require 'pry-byebug'

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

      def insert(value)
        current_node = @root
        new_node = Node.new(value)
        loop do
          if value < current_node.value
            if current_node.left_child == nil
              current_node.left_child = new_node
              break
            elsif current_node.left_child != nil
              current_node = current_node.left_child
              next
              end
          elsif value > current_node.value
            if current_node.right_child == nil
              current_node.right_child = new_node
              break
            elsif current_node.right_child != nil
                current_node = current_node.right_child
                next
              end
            end
        end
      end

      def delete(value)
        current_node = @root
        previous_node = @root
        if value < current_node.value && current_node.left_child != nil
          previous_node = current_node
          current_node = current_node.left_child
        elsif value > current_node.value && current_node.right_child != nil
          previous_node = current_node
          current_node = current_node.right_child
        elsif value == current_node.value && current_node.left_child == nil && current_node.right_child == nil
          current_node.delete
        elsif value == current_node.value && current_node.left_child == nil && current_node.right_child != nil
          right_child = current_node.right_child
          current_node = right_child
          current_node.right_child = nil

        end
      end




end

tree = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])
tree.pretty_print
tree.insert(15)
tree.insert(6)
tree.pretty_print
