using Microsoft.AspNetCore.Mvc;
using System.Net.Http;
using System.Threading.Tasks;
using System.Text.Json;

[Route("api/[controller]")]
[ApiController]
public class GifsController : ControllerBase
{
    private readonly HttpClient _httpClient;

    public GifsController(HttpClient httpClient)
    {
        _httpClient = httpClient;
    }

    [HttpGet("{id}")]
    public async Task<IActionResult> GetGif(int id)
    {
        try
        {
            var apikey = "LIVDSRZULELA";
            var searchTerm = "excited";
            var response = await _httpClient.GetStringAsync($"https://g.tenor.com/v1/search?q={searchTerm}&key={apikey}&limit=1");
            var jsonDocument = JsonDocument.Parse(response);
            
            if (id >= 0 && id < jsonDocument.RootElement.GetProperty("results").GetArrayLength())
            {
                var gifUrl = jsonDocument.RootElement.GetProperty("results")[id]
                    .GetProperty("media")[0]
                    .GetProperty("webm")
                    .GetProperty("preview")
                    .GetString();
                
                return Ok(new { id = id, url = gifUrl });
            }
            else
            {
                return NotFound("GIF not found");
            }
        }
        catch (Exception ex)
        {
            return StatusCode(500, $"Internal server error: {ex.Message}");
        }
    }
}

