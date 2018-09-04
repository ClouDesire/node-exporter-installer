# Inspec test for recipe node-exporter-installer::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

describe port(9100) do
  it { should be_listening }
  its('processes') { should include 'node_exporter' }
end
