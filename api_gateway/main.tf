resource "aws_api_gateway_rest_api" "API" {
  name        = "ugro-api-eks-${var.environment}"
  description = "Ugro API for EKS"
  endpoint_configuration {
    types = ["REGIONAL"]
  }
}

resource "aws_api_gateway_resource" "APIResource" {
  rest_api_id = aws_api_gateway_rest_api.API.id
  parent_id   = aws_api_gateway_rest_api.API.root_resource_id
  path_part   = "{proxy+}"
}

resource "aws_api_gateway_method" "APIMethod" {
  rest_api_id   = aws_api_gateway_rest_api.API.id
  resource_id   = aws_api_gateway_resource.APIResource.id
  http_method   = "GET"
  authorization = "NONE"
   request_parameters = {
    "method.request.path.proxy" = true
  }
}

resource "aws_api_gateway_method" "APIANYMethod" {
  rest_api_id   = aws_api_gateway_rest_api.API.id
  resource_id   = aws_api_gateway_resource.APIResource.id
  http_method   = "ANY"
  authorization = "NONE"
   request_parameters = {
    "method.request.path.proxy" = true
  }
}

resource "aws_api_gateway_integration" "APIANYIntegration" {
  rest_api_id          = aws_api_gateway_rest_api.API.id
  resource_id          = aws_api_gateway_resource.APIResource.id
  http_method          = aws_api_gateway_method.APIANYMethod.http_method
  type                 = "HTTP_PROXY"
  uri                  = "https://httpbin.org/anything/{proxy}"
  integration_http_method = "ANY"
  cache_key_parameters = ["method.request.path.proxy"]
  timeout_milliseconds = 29000
  request_parameters = {
    "integration.request.path.proxy" = "method.request.path.proxy"
  }
}
resource "aws_api_gateway_method_response" "any_response_200" {
  rest_api_id = aws_api_gateway_rest_api.API.id
  resource_id = aws_api_gateway_resource.APIResource.id
  http_method = aws_api_gateway_method.APIANYMethod.http_method
  status_code = "200"
}
resource "aws_api_gateway_integration_response" "any_response_200" {
  rest_api_id = aws_api_gateway_rest_api.API.id
  resource_id = aws_api_gateway_resource.APIResource.id
  http_method = aws_api_gateway_method.APIANYMethod.http_method
  status_code = aws_api_gateway_method_response.any_response_200.status_code
}
resource "aws_api_gateway_deployment" "any_api_options" {
  rest_api_id = aws_api_gateway_rest_api.API.id
  triggers = {
    redeployment = sha1(jsonencode([aws_api_gateway_resource.APIResource.id,
      aws_api_gateway_method.APIANYMethod.id,
      aws_api_gateway_integration.APIANYIntegration.id,
    ]))
  }
  lifecycle {
    create_before_destroy = true
  }
}
resource "aws_api_gateway_integration" "APIIntegration" {
  rest_api_id          = aws_api_gateway_rest_api.API.id
  resource_id          = aws_api_gateway_resource.APIResource.id
  http_method          = aws_api_gateway_method.APIMethod.http_method
  type                 = "HTTP_PROXY"
  uri                  = "https://httpbin.org/anything/{proxy}"
  integration_http_method = "GET"
  cache_key_parameters = ["method.request.path.proxy"]
  timeout_milliseconds = 29000
  request_parameters = {
    "integration.request.path.proxy" = "method.request.path.proxy"
  }
}

resource "aws_api_gateway_deployment" "apistage" {
  depends_on = [
    aws_api_gateway_integration.APIIntegration
  ]
  rest_api_id = aws_api_gateway_rest_api.API.id
  stage_name  = "prod"
}