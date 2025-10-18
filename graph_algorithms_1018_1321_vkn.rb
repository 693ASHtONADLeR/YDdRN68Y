# 代码生成时间: 2025-10-18 13:21:45
# graph_algorithms.rb
# This Ruby script provides basic graph algorithms using Ruby and Rails framework.

# Define a simple Graph class
class Graph
  attr_reader :nodes, :edges
  attr_accessor :edge_weights
  
  def initialize
    @nodes = []
    @edges = []
    @edge_weights = {}
  end
  
  # Add a node to the graph
  def add_node(node)
    @nodes.push(node) unless @nodes.include?(node)
  end
  
  # Add an edge to the graph, optionally with a weight
  def add_edge(node1, node2, weight = 0)
    unless @nodes.include?(node1) && @nodes.include?(node2)
      raise ArgumentError, 'Both nodes must be present in the graph'
    end
    unless @edge_weights[node1] && @edge_weights[node1][node2]
      @edge_weights[node1] = {} unless @edge_weights[node1]
      @edge_weights[node1][node2] = weight
      @edges.push([node1, node2])
    end
  end
  
  # Returns all paths from start to finish
  def find_paths(start, finish)
    return [] unless @nodes.include?(start) && @nodes.include?(finish)
    expand_path([], [start], finish)
  end
  
  private
  
  # Helper method to expand paths
  def expand_path(current_path, next_nodes, finish)
    if next_nodes.last == finish
      return [current_path + [finish]]
    elsif next_nodes.empty?
      return []
    else
      paths = []
      next_nodes.each do |node|
        connected_nodes = @edge_weights[node] ? @edge_weights[node].keys : []
        connected_nodes.each do |next_node|
          unless current_path.include?(next_node)
            paths += expand_path(current_path + [node], [next_node] + next_nodes, finish)
          end
        end
      end
      paths
    end
  end
end

# Example usage of the Graph class
begin
  graph = Graph.new
  graph.add_node(:A)
  graph.add_node(:B)
  graph.add_node(:C)
  graph.add_edge(:A, :B)
  graph.add_edge(:B, :C)
  graph.add_edge(:A, :C)

  # Find all paths from node A to node C
  paths = graph.find_paths(:A, :C)
  puts 'Paths from A to C: ' + paths.inspect
rescue ArgumentError => e
  puts 'Error: ' + e.message
end