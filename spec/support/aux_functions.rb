# frozen_string_literal: true

def create_snippet_payload
  {
    data: {
      type: 'snippet',
      attributes: {
        input_key: 'field2',
        input_value: 'value2'
      }
    }
  }
end

def update_snippet_payload(id)
  {
    id: id,
    data: {
      type: 'snippet',
      id: id,
      attributes: {
        input_key: 'field3',
        input_value: 'value3'
      }
    }
  }
end

def create_document_payload(name)
  {
    data: {
      type: 'document',
      attributes: {
        name: name,
        data: { merchandises: { hola: 1 } }
      }
    }
  }
end

def update_document_payload(id, name)
  {
    id: id,
    data: {
      type: 'document',
      id: id,
      attributes: {
        name: name
      }
    }
  }
end

def create_permission_payload(doc_id, user_id)
  {
    document_id: doc_id,
    data: {
      type: 'permissions',
      attributes: {
        read: true,
        write: true,
        user_id: user_id
      }
    }
  }
end

def update_permission_payload(doc_id, id, user_id)
  {
    document_id: doc_id,
    id: id,
    data: {
      type: 'permissions',
      attributes: {
        read: true,
        write: true,
        user_id: user_id
      }
    }
  }
end

def user_info_payload
  '{"data":{"id":"1234"}}'
end
